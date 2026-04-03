extends CharacterBody2D
## Player movement controller with StringName state machine.
## Handles run, jump, slide, wall slide, wall jump, and velocity chaining.

signal jumped
signal landed
signal slide_started
signal slide_ended
signal wall_slide_started
signal player_died
signal respawned
signal attack_started
signal attack_hit(target: Node2D)

# --- States ---
const STATE_IDLE := &"idle"
const STATE_RUN := &"run"
const STATE_JUMP := &"jump"
const STATE_FALL := &"fall"
const STATE_SLIDE := &"slide"
const STATE_WALL_SLIDE := &"wall_slide"
const STATE_WALL_JUMP := &"wall_jump"

# --- Movement tuning (adjust these in the editor!) ---
@export_group("Running")
@export var max_speed: float = 120.0
@export var acceleration: float = 900.0
@export var friction: float = 1200.0

@export_group("Jumping")
@export var jump_force: float = -220.0
@export var jump_cut_multiplier: float = 0.4
@export var coyote_frames: int = 6
@export var jump_buffer_frames: int = 6

@export_group("Gravity")
@export var gravity: float = 600.0
@export var max_fall_speed: float = 300.0

@export_group("Wall Slide")
@export var wall_slide_speed: float = 40.0
@export var wall_jump_force: Vector2 = Vector2(140.0, -200.0)

@export_group("Slide")
@export var slide_speed: float = 180.0
@export var slide_duration: float = 0.35
@export var slide_cooldown: float = 0.1

@export_group("Attack")
@export var attack_damage: int = 1
@export var attack_hitbox_frames: int = 4  # Active window at 60Hz
@export var attack_cooldown_frames: int = 12  # ~200ms between attacks

# --- Node references ---
@onready var sprite: ColorRect = $Sprite2D
@onready var blade_pivot: Node2D = $BladePivot
@onready var throw_physics: Node = $BladePivot/Blade/ThrowPhysics
@onready var attack_hitbox: Area2D = $AttackHitbox
@onready var attack_shape: CollisionShape2D = $AttackHitbox/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# --- Private state ---
var _current_state: StringName = STATE_IDLE
var _facing_right: bool = true
var _coyote_timer: int = 0
var _jump_buffer_timer: int = 0
var _slide_timer: float = 0.0
var _slide_cooldown_timer: float = 0.0
var _is_invincible: bool = false
var _last_safe_position: Vector2 = Vector2.ZERO
var _wall_direction: int = 0  # -1 left, 1 right, 0 none
var _is_attacking: bool = false
var _attack_timer: int = 0
var _attack_cooldown_timer: int = 0
var _attack_targets_hit: Array[Node2D] = []  # Prevent multi-hit per swing


func _ready() -> void:
	_last_safe_position = global_position


func _physics_process(delta: float) -> void:
	_update_timers(delta)
	_detect_wall()
	_try_attack()
	_update_attack()

	match _current_state:
		STATE_IDLE:
			_state_idle(delta)
		STATE_RUN:
			_state_run(delta)
		STATE_JUMP:
			_state_jump(delta)
		STATE_FALL:
			_state_fall(delta)
		STATE_SLIDE:
			_state_slide(delta)
		STATE_WALL_SLIDE:
			_state_wall_slide(delta)
		STATE_WALL_JUMP:
			_state_wall_jump(delta)

	move_and_slide()
	_update_safe_position()
	_update_sprite()


# --- State handlers ---

func _state_idle(delta: float) -> void:
	_apply_gravity(delta)
	_apply_friction(delta)
	if not is_on_floor():
		_change_state(STATE_FALL)
		return
	if _try_jump():
		return
	if _try_slide():
		return
	if _get_move_input() != 0.0:
		_change_state(STATE_RUN)


func _state_run(delta: float) -> void:
	_apply_gravity(delta)
	var input_dir: float = _get_move_input()
	if input_dir == 0.0:
		_change_state(STATE_IDLE)
		return
	velocity.x = move_toward(velocity.x, input_dir * max_speed, acceleration * delta)
	if not is_on_floor():
		_change_state(STATE_FALL)
		return
	if _try_jump():
		return
	if _try_slide():
		return


func _state_jump(delta: float) -> void:
	_apply_gravity(delta)
	_apply_air_movement(delta)
	# Jump cut — release jump early for short hop
	if not Input.is_action_pressed("jump") and velocity.y < 0:
		velocity.y *= jump_cut_multiplier
	if velocity.y >= 0:
		_change_state(STATE_FALL)
		return
	if _wall_direction != 0 and _get_move_input() == float(_wall_direction):
		_change_state(STATE_WALL_SLIDE)


func _state_fall(delta: float) -> void:
	_apply_gravity(delta)
	_apply_air_movement(delta)
	if is_on_floor():
		landed.emit()
		if _get_move_input() != 0.0:
			_change_state(STATE_RUN)
		else:
			_change_state(STATE_IDLE)
		return
	if _try_jump():  # Coyote time / jump buffer
		return
	if _wall_direction != 0 and _get_move_input() == float(_wall_direction):
		_change_state(STATE_WALL_SLIDE)


func _state_slide(delta: float) -> void:
	_slide_timer -= delta
	var dir: float = 1.0 if _facing_right else -1.0
	velocity.x = dir * slide_speed
	velocity.y = 0.0 if is_on_floor() else velocity.y
	_apply_gravity(delta)
	if _slide_timer <= 0.0:
		_change_state(STATE_IDLE if _get_move_input() == 0.0 else STATE_RUN)
		slide_ended.emit()


func _state_wall_slide(delta: float) -> void:
	# Kill upward momentum when entering wall slide — you bonk, not float
	if velocity.y < 0:
		velocity.y = 0.0
	velocity.y = min(velocity.y + gravity * delta * 0.1, wall_slide_speed)
	if is_on_floor():
		_change_state(STATE_IDLE)
		return
	if _wall_direction == 0:
		_change_state(STATE_FALL)
		return
	if Input.is_action_just_pressed("jump"):
		# Wall jump — push away from wall
		velocity.x = -_wall_direction * wall_jump_force.x
		velocity.y = wall_jump_force.y
		_facing_right = _wall_direction < 0
		_change_state(STATE_WALL_JUMP)
		jumped.emit()


func _state_wall_jump(delta: float) -> void:
	_apply_gravity(delta)
	# Brief period where player can't redirect back to wall
	_apply_air_movement(delta)
	if velocity.y >= 0:
		_change_state(STATE_FALL)


# --- State machine ---

func _change_state(new_state: StringName) -> void:
	_exit_state(_current_state)
	_current_state = new_state
	_enter_state(new_state)


func _enter_state(state: StringName) -> void:
	match state:
		STATE_JUMP:
			velocity.y = jump_force
			_coyote_timer = 0
			jumped.emit()
		STATE_SLIDE:
			_slide_timer = slide_duration
			_is_invincible = true
			slide_started.emit()
		STATE_WALL_SLIDE:
			wall_slide_started.emit()
		STATE_FALL:
			if _current_state == STATE_IDLE or _current_state == STATE_RUN:
				_coyote_timer = coyote_frames


func _exit_state(state: StringName) -> void:
	match state:
		STATE_SLIDE:
			_is_invincible = false
			_slide_cooldown_timer = slide_cooldown


# --- Attack overlay ---

func _try_attack() -> void:
	if not Input.is_action_just_pressed("attack"):
		return
	if _is_attacking or _attack_cooldown_timer > 0:
		return
	if not throw_physics.is_held():
		return
	_is_attacking = true
	_attack_timer = attack_hitbox_frames
	_attack_targets_hit.clear()
	# Position hitbox on facing side
	var offset_x: float = 8.0 if _facing_right else -8.0
	attack_shape.position = Vector2(offset_x, -7.0)
	attack_hitbox.monitoring = true
	animation_player.play("attack_swing")
	attack_started.emit()


func _update_attack() -> void:
	if not _is_attacking:
		return
	# Check for overlapping hurtboxes
	for area in attack_hitbox.get_overlapping_areas():
		if area in _attack_targets_hit:
			continue
		var target: Node = area.get_parent()
		if target.has_method("take_damage"):
			target.take_damage(attack_damage)
			_attack_targets_hit.append(area)
			attack_hit.emit(target)
	_attack_timer -= 1
	if _attack_timer <= 0:
		_is_attacking = false
		attack_hitbox.monitoring = false
		_attack_cooldown_timer = attack_cooldown_frames


# --- Helpers ---

func _get_move_input() -> float:
	return Input.get_axis("move_left", "move_right")


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y = min(velocity.y + gravity * delta, max_fall_speed)


func _apply_friction(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0.0, friction * delta)


func _apply_air_movement(delta: float) -> void:
	var input_dir: float = _get_move_input()
	if input_dir != 0.0:
		velocity.x = move_toward(velocity.x, input_dir * max_speed, acceleration * delta * 0.8)
		_facing_right = input_dir > 0
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta * 0.3)


func _try_jump() -> bool:
	var can_jump: bool = is_on_floor() or _coyote_timer > 0
	var wants_jump: bool = Input.is_action_just_pressed("jump") or _jump_buffer_timer > 0
	if can_jump and wants_jump:
		_change_state(STATE_JUMP)
		return true
	if Input.is_action_just_pressed("jump") and not can_jump:
		_jump_buffer_timer = jump_buffer_frames
	return false


func _try_slide() -> bool:
	if Input.is_action_just_pressed("slide") and is_on_floor() and _slide_cooldown_timer <= 0.0:
		_change_state(STATE_SLIDE)
		return true
	return false


func _detect_wall() -> int:
	if is_on_wall():
		# Determine wall direction from collision normal
		for i in get_slide_collision_count():
			var collision: KinematicCollision2D = get_slide_collision(i)
			if collision.get_normal().x > 0.5:
				_wall_direction = -1  # Wall to the left
				return _wall_direction
			elif collision.get_normal().x < -0.5:
				_wall_direction = 1  # Wall to the right
				return _wall_direction
	_wall_direction = 0
	return 0


func _update_timers(delta: float) -> void:
	if _coyote_timer > 0:
		_coyote_timer -= 1
	if _jump_buffer_timer > 0:
		_jump_buffer_timer -= 1
	if _slide_cooldown_timer > 0.0:
		_slide_cooldown_timer -= delta
	if _attack_cooldown_timer > 0:
		_attack_cooldown_timer -= 1


func _update_safe_position() -> void:
	if is_on_floor() and _current_state != STATE_SLIDE:
		_last_safe_position = global_position


func _update_sprite() -> void:
	# ColorRect placeholder — no flip needed. Will swap to Sprite2D with real art later.
	pass


func respawn() -> void:
	global_position = _last_safe_position
	velocity = Vector2.ZERO
	_change_state(STATE_IDLE)
	respawned.emit()


func apply_momentum(external_velocity: Vector2) -> void:
	## Called by TeleportExecutor to apply teleport exit momentum.
	velocity = external_velocity
	if not is_on_floor():
		_change_state(STATE_FALL)


func apply_knockback(force: Vector2) -> void:
	## Called by PlayerHealth when taking damage.
	velocity = force
	if _current_state == STATE_SLIDE:
		_slide_timer = 0.0
		slide_ended.emit()
	_change_state(STATE_FALL)


func is_sliding() -> bool:
	return _current_state == STATE_SLIDE


func is_invincible() -> bool:
	return _is_invincible


func get_facing_direction() -> Vector2:
	return Vector2.RIGHT if _facing_right else Vector2.LEFT


func is_attacking() -> bool:
	return _is_attacking

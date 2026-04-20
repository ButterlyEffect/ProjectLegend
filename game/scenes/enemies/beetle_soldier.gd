extends "res://scenes/enemies/enemy_base.gd"
## Beetle Soldier — first real enemy.
## States: PATROL → ALERT → APPROACH → TELEGRAPH → SWING → COOLDOWN → ...
## Attack swing is parry-detectable (DamageZone on layer 64).

const STATE_PATROL := &"patrol"
const STATE_ALERT := &"alert"
const STATE_APPROACH := &"approach"
const STATE_TELEGRAPH := &"telegraph"
const STATE_SWING := &"swing"
const STATE_COOLDOWN := &"cooldown"
const STATE_HURT := &"hurt"

@export_group("Movement")
@export var patrol_speed: float = 30.0
@export var approach_speed: float = 60.0
@export var patrol_distance: float = 60.0  # Half-width from spawn point

@export_group("Detection & Attack")
@export var detection_radius: float = 90.0
@export var lose_interest_frames: int = 90  # Frames out-of-range before giving up chase (~1.5s)
@export var attack_range: float = 22.0
@export var contact_damage: int = 1

@export_group("Attack Cycle")
@export var alert_frames: int = 24    # Brief "I see you" pause
@export var telegraph_frames: int = 30
@export var swing_frames: int = 16
@export var cooldown_frames: int = 36
@export var hurt_stun_frames: int = 14

# --- Internal ---
var _spawn_position: Vector2
var _facing_right: bool = true
var _phase_timer: int = 0
var _telegraph_flash_timer: int = 0
var _disinterest_timer: int = 0
var _patrol_flip_cooldown: int = 0
var _player: Node2D


func _ready() -> void:
	super._ready()
	_spawn_position = global_position
	_player = get_tree().get_first_node_in_group("player")
	$DamageZone.monitoring = false
	$DamageZone.monitorable = false
	$AttackArm.visible = false
	_change_state(STATE_PATROL)


func _update_state(_delta: float) -> void:
	# Re-acquire player ref if it was missing (e.g., level reload)
	if _player == null:
		_player = get_tree().get_first_node_in_group("player")

	match _current_state:
		STATE_PATROL:
			_update_patrol()
		STATE_ALERT:
			_update_alert()
		STATE_APPROACH:
			_update_approach()
		STATE_TELEGRAPH:
			_update_telegraph()
		STATE_SWING:
			_update_swing()
		STATE_COOLDOWN:
			_update_cooldown()
		STATE_HURT:
			_update_hurt()


func _update_patrol() -> void:
	velocity.x = (1.0 if _facing_right else -1.0) * patrol_speed
	var dx: float = global_position.x - _spawn_position.x
	var hit_bound: bool = (_facing_right and dx > patrol_distance) or (not _facing_right and dx < -patrol_distance)
	if _patrol_flip_cooldown > 0:
		_patrol_flip_cooldown -= 1
	elif hit_bound or is_on_wall():
		_facing_right = not _facing_right
		_patrol_flip_cooldown = 12  # ~200ms before another flip is allowed
	if _can_detect_player():
		_face_player()
		_change_state(STATE_ALERT)


func _update_alert() -> void:
	velocity.x = 0.0
	_phase_timer -= 1
	if _phase_timer <= 0:
		_change_state(STATE_APPROACH)


func _update_approach() -> void:
	if _player == null:
		_change_state(STATE_PATROL)
		return
	# Track disinterest — give up if player stays out of range long enough
	if _can_detect_player():
		_disinterest_timer = 0
	else:
		_disinterest_timer += 1
		if _disinterest_timer >= lose_interest_frames:
			_change_state(STATE_PATROL)
			return
	_face_player()
	var to_player_x: float = _player.global_position.x - global_position.x
	var distance: float = absf(to_player_x)
	if distance <= attack_range:
		velocity.x = 0.0
		_change_state(STATE_TELEGRAPH)
		return
	velocity.x = (1.0 if _facing_right else -1.0) * approach_speed


func _update_telegraph() -> void:
	velocity.x = 0.0
	_telegraph_flash_timer -= 1
	if _telegraph_flash_timer <= 0:
		_telegraph_flash_timer = 6
		$AttackArm.visible = not $AttackArm.visible
	_phase_timer -= 1
	if _phase_timer <= 0:
		_change_state(STATE_SWING)


func _update_swing() -> void:
	velocity.x = 0.0
	for area in $DamageZone.get_overlapping_areas():
		var target: Node = area.get_parent()
		var health: Node = target.get_node_or_null("PlayerHealth")
		if health and health.has_method("take_damage"):
			health.take_damage(contact_damage, global_position)
	_phase_timer -= 1
	if _phase_timer <= 0:
		_change_state(STATE_COOLDOWN)


func _update_cooldown() -> void:
	velocity.x = 0.0
	_phase_timer -= 1
	if _phase_timer <= 0:
		if _can_detect_player():
			_change_state(STATE_APPROACH)
		else:
			_change_state(STATE_PATROL)


func _update_hurt() -> void:
	# Knockback decays naturally via friction; just count down
	velocity.x = move_toward(velocity.x, 0.0, 600.0 * get_physics_process_delta_time())
	_phase_timer -= 1
	if _phase_timer <= 0:
		if _can_detect_player():
			_change_state(STATE_APPROACH)
		else:
			_change_state(STATE_PATROL)


func _enter_state(state: StringName) -> void:
	match state:
		STATE_PATROL:
			$Visual.color = Color(0.55, 0.4, 0.25, 1.0)
			$AttackArm.visible = false
			$DamageZone.monitoring = false
			$DamageZone.monitorable = false
		STATE_ALERT:
			$Visual.color = Color(1.0, 0.7, 0.2, 1.0)
			_phase_timer = alert_frames
		STATE_APPROACH:
			$Visual.color = Color(0.7, 0.35, 0.2, 1.0)
			_disinterest_timer = 0
		STATE_TELEGRAPH:
			_phase_timer = telegraph_frames
			_telegraph_flash_timer = 6
			$AttackArm.color = Color(1.0, 0.6, 0.0, 0.45)
			$AttackArm.visible = true
			_orient_attack()
		STATE_SWING:
			_phase_timer = swing_frames
			$DamageZone.monitoring = true
			$DamageZone.monitorable = true
			$AttackArm.color = Color(1.0, 0.15, 0.15, 0.95)
			$AttackArm.visible = true
			$Visual.color = Color(1.0, 0.3, 0.2, 1.0)
		STATE_COOLDOWN:
			_phase_timer = cooldown_frames
			$DamageZone.monitoring = false
			$DamageZone.monitorable = false
			$AttackArm.visible = false
			$Visual.color = Color(0.45, 0.3, 0.2, 1.0)
		STATE_HURT:
			_phase_timer = hurt_stun_frames
			$DamageZone.monitoring = false
			$DamageZone.monitorable = false
			$AttackArm.visible = false


func _face_player() -> void:
	if _player:
		_facing_right = _player.global_position.x > global_position.x


func _orient_attack() -> void:
	# Place attack arm and damage zone in front of facing direction
	var dir: float = 1.0 if _facing_right else -1.0
	$AttackArm.offset_left = dir * 4 - 14
	$AttackArm.offset_right = dir * 4 + 14
	$DamageZone/CollisionShape2D.position = Vector2(dir * 18, -7)


func _can_detect_player() -> bool:
	if _player == null:
		return false
	return global_position.distance_to(_player.global_position) <= detection_radius


# Override take_damage to add hurt state + knockback
func take_damage(amount: int) -> void:
	var was_alive: bool = not _is_dead
	super.take_damage(amount)
	if was_alive and not _is_dead:
		var knockback_source: Vector2 = _player.global_position if _player else global_position
		apply_knockback_from(knockback_source)
		_change_state(STATE_HURT)

extends Area2D
## Blade throw trajectory, 8-directional aiming, embedding, and clearance detection.
## Child of Blade scene. Communicates with siblings via direct calls, emits signals outward.

signal blade_thrown(direction: Vector2)
signal blade_embedded(position: Vector2, surface_type: StringName)
signal blade_recalled
signal blade_in_flight
signal teleport_clearance_checked(is_clear: bool, position: Vector2)

# --- States ---
const STATE_HELD := &"held"
const STATE_IN_FLIGHT := &"in_flight"
const STATE_EMBEDDED := &"embedded"

# --- Tuning ---
@export var throw_speed: float = 150.0  # Overridden by trust stage
@export var max_range: float = 200.0    # Overridden by trust stage

# --- Node references ---
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var clearance_check: Area2D = $ClearanceCheck  # Sized to player body

# --- Private state ---
var _current_state: StringName = STATE_HELD
var _throw_direction: Vector2 = Vector2.ZERO
var _start_position: Vector2 = Vector2.ZERO
var _distance_traveled: float = 0.0
var _player: CharacterBody2D = null
var _world_position: Vector2 = Vector2.ZERO  # Blade position in world space
var _initial_velocity: Vector2 = Vector2.ZERO  # Player velocity at time of throw


func _ready() -> void:
	# ThrowPhysics -> Blade -> BladePivot -> Player
	_player = get_parent().get_parent().get_parent() as CharacterBody2D
	_apply_trust_params(GameManager.get_trust_params())
	GameManager.trust_stage_changed.connect(_on_trust_stage_changed)
	set_physics_process(false)
	visible = false  # Hidden when held


func _physics_process(delta: float) -> void:
	if _current_state != STATE_IN_FLIGHT:
		set_physics_process(false)
		return

	# Blade moves at throw_speed in throw direction, plus player's velocity at time of throw
	var blade_velocity: Vector2 = _throw_direction * throw_speed + _initial_velocity
	var movement: Vector2 = blade_velocity * delta
	var prev_position: Vector2 = _world_position
	_world_position += movement
	_distance_traveled += movement.length()

	# Check if blade hit a surface BEFORE updating visual
	# Raycast from previous position to new position to catch pass-through
	if _check_surface_hit(prev_position, _world_position):
		return

	# Update visual position
	global_position = _world_position

	# Check if max range exceeded
	if _distance_traveled >= max_range:
		_change_state(STATE_EMBEDDED)
		blade_embedded.emit(_world_position, &"air")
		print("Blade max range reached at ", _world_position)


func throw_blade(direction: Vector2) -> void:
	if _current_state != STATE_HELD:
		return
	_throw_direction = direction.normalized()
	# Start from the player's current world position
	_world_position = _player.global_position
	_initial_velocity = _player.velocity  # Inherit player momentum
	_start_position = _world_position
	_distance_traveled = 0.0
	_change_state(STATE_IN_FLIGHT)
	blade_thrown.emit(_throw_direction)
	print("Blade thrown from ", _world_position, " dir ", _throw_direction)


func recall() -> void:
	if _current_state == STATE_HELD:
		return
	_change_state(STATE_HELD)
	blade_recalled.emit()


func check_teleport_clearance() -> bool:
	## Returns true if the player body can fit at the blade's current position.
	# For now, always return true — proper clearance check comes later
	return true


func get_blade_position() -> Vector2:
	return _world_position


func get_flight_direction() -> Vector2:
	return _throw_direction


func is_held() -> bool:
	return _current_state == STATE_HELD


func is_in_flight() -> bool:
	return _current_state == STATE_IN_FLIGHT


func is_embedded() -> bool:
	return _current_state == STATE_EMBEDDED


# --- State machine ---

func _change_state(new_state: StringName) -> void:
	_exit_state(_current_state)
	_current_state = new_state
	_enter_state(new_state)


func _enter_state(state: StringName) -> void:
	match state:
		STATE_HELD:
			visible = false
			top_level = false
			set_physics_process(false)
			# Snap back to player
			position = Vector2.ZERO
		STATE_IN_FLIGHT:
			visible = true
			top_level = true  # Detach from player transform
			global_position = _world_position
			set_physics_process(true)
			blade_in_flight.emit()
		STATE_EMBEDDED:
			visible = true
			top_level = true
			global_position = _world_position
			set_physics_process(false)
			print("Blade embedded, world pos: ", _world_position)


func _exit_state(_state: StringName) -> void:
	pass


func _check_surface_hit(from_pos: Vector2, to_pos: Vector2) -> bool:
	# Raycast from previous frame position to current — catches fast-moving blade
	var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(
		from_pos,
		to_pos,
		1  # Collision mask for terrain (layer 1)
	)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	var result: Dictionary = space_state.intersect_ray(query)
	if result:
		# Place blade at hit point, offset slightly back along throw direction so it's visible
		var hit_normal: Vector2 = result.normal
		_world_position = result.position + hit_normal * 3.0
		global_position = _world_position
		_change_state(STATE_EMBEDDED)
		blade_embedded.emit(_world_position, &"wood")
		return true
	return false


func _apply_trust_params(params: Dictionary) -> void:
	throw_speed = params.get("throw_speed", 150.0)
	max_range = params.get("max_range", 200.0)


func _on_trust_stage_changed(_new_stage: StringName) -> void:
	_apply_trust_params(GameManager.get_trust_params())

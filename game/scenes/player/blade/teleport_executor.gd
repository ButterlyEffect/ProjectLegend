extends Node2D
## Executes dash-to-blade teleportation with momentum preservation.
## Child of Blade scene. Calls ThrowPhysics (sibling) and MovementController (player).

signal teleport_succeeded(destination: Vector2)
signal teleport_failed(reason: StringName)

# --- Tuning ---
@export var teleport_speed: float = 300.0  # Overridden by trust stage
@export var landing_lag_frames: int = 12    # Overridden by trust stage

# --- Node references ---
var _throw_physics: Node = null  # ThrowPhysics sibling
var _player: CharacterBody2D = null

# --- Private state ---
var _landing_lag_timer: int = 0


func _ready() -> void:
	_throw_physics = get_parent().get_node("ThrowPhysics")
	_player = get_parent().get_parent().get_parent() as CharacterBody2D  # TeleportExecutor > Blade > BladePivot > Player
	_apply_trust_params(GameManager.get_trust_params())
	GameManager.trust_stage_changed.connect(_on_trust_stage_changed)


func _physics_process(_delta: float) -> void:
	if _landing_lag_timer > 0:
		_landing_lag_timer -= 1


func try_teleport() -> void:
	if not _throw_physics:
		return

	# Can teleport to blade whether in flight or embedded
	if _throw_physics.is_held():
		return

	var blade_pos: Vector2 = _throw_physics.get_blade_position()

	# Clearance check
	var is_clear: bool = _throw_physics.check_teleport_clearance()
	if not is_clear:
		teleport_failed.emit(&"no_clearance")
		return

	# Calculate exit momentum
	var exit_velocity: Vector2 = _calculate_exit_momentum()

	# Execute teleport — move player to blade position
	_player.global_position = blade_pos

	# Apply momentum
	_player.apply_momentum(exit_velocity)

	# Start landing lag
	_landing_lag_timer = landing_lag_frames

	# Return blade to player
	_throw_physics.recall()

	teleport_succeeded.emit(blade_pos)


func _calculate_exit_momentum() -> Vector2:
	if _throw_physics.is_in_flight():
		# Mid-air teleport: combine player velocity with blade flight direction
		var blade_dir: Vector2 = _throw_physics.get_flight_direction()
		var player_vel: Vector2 = _player.velocity
		return (player_vel + blade_dir * teleport_speed * 0.5).limit_length(teleport_speed)
	else:
		# Embedded teleport: preserve player's current momentum direction
		var player_vel: Vector2 = _player.velocity
		if player_vel.length() < 10.0:
			return Vector2.ZERO
		return player_vel.normalized() * min(player_vel.length(), teleport_speed)


func is_in_landing_lag() -> bool:
	return _landing_lag_timer > 0


func _apply_trust_params(params: Dictionary) -> void:
	teleport_speed = params.get("teleport_speed", 300.0)
	landing_lag_frames = params.get("landing_lag", 12)


func _on_trust_stage_changed(_new_stage: StringName) -> void:
	_apply_trust_params(GameManager.get_trust_params())

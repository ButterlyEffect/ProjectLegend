extends Node2D
## Test level for movement and blade prototyping.
## Handles blade input routing to ThrowPhysics and TeleportExecutor.

@onready var player: CharacterBody2D = $Player
@onready var throw_physics: Node = $Player/BladePivot/Blade/ThrowPhysics
@onready var teleport_executor: Node = $Player/BladePivot/Blade/TeleportExecutor
@onready var player_health: Node = $Player/PlayerHealth
@onready var kill_zone: Area2D = $KillZone

var _range_indicator: Line2D


func _ready() -> void:
	if kill_zone:
		kill_zone.body_entered.connect(_on_kill_zone_entered)
	# Connect blade signals for debug feedback
	if throw_physics:
		throw_physics.blade_embedded.connect(_on_blade_embedded)
		throw_physics.blade_recalled.connect(_on_blade_recalled)
	if teleport_executor:
		teleport_executor.teleport_succeeded.connect(_on_teleport_succeeded)
		teleport_executor.teleport_failed.connect(_on_teleport_failed)
	# Connect attack signals
	player.attack_started.connect(_on_attack_started)
	player.attack_hit.connect(_on_attack_hit)
	# Connect health signals
	player_health.player_damaged.connect(_on_player_damaged)
	player_health.player_died.connect(_on_player_died)
	_range_indicator = Line2D.new()
	_range_indicator.top_level = true
	_range_indicator.width = 1.0
	_range_indicator.default_color = Color(1.0, 1.0, 0.6, 0.5)
	_range_indicator.visible = false
	add_child(_range_indicator)


func _physics_process(_delta: float) -> void:
	# Blade throw input — hold to aim, release to throw
	if Input.is_action_just_released("throw_blade") and throw_physics.is_held():
		var aim: Vector2 = InputManager.get_aim_direction()
		if aim == Vector2.ZERO:
			aim = player.get_facing_direction()
		throw_physics.throw_blade(aim)

	# Teleport input
	if Input.is_action_just_pressed("teleport"):
		teleport_executor.try_teleport()

	# Recall input
	if Input.is_action_just_pressed("recall_blade"):
		throw_physics.recall()

	_update_range_indicator()


func _update_range_indicator() -> void:
	if not throw_physics.is_held() or not Input.is_action_pressed("throw_blade"):
		_range_indicator.visible = false
		return
	var aim: Vector2 = InputManager.get_aim_direction()
	if aim == Vector2.ZERO:
		aim = player.get_facing_direction()
	_range_indicator.visible = true
	_range_indicator.clear_points()
	_range_indicator.add_point(player.global_position)
	_range_indicator.add_point(player.global_position + aim * throw_physics.max_range)


func _on_kill_zone_entered(body: Node2D) -> void:
	if body == player:
		player.respawn()
		throw_physics.recall()
		player_health._reset()


func _on_blade_embedded(pos: Vector2, surface: StringName) -> void:
	print("Blade embedded at ", pos, " in ", surface)


func _on_blade_recalled() -> void:
	print("Blade recalled")


func _on_teleport_succeeded(dest: Vector2) -> void:
	print("Teleported to ", dest)


func _on_teleport_failed(reason: StringName) -> void:
	print("Teleport failed: ", reason)


func _on_attack_started() -> void:
	print("Attack swing!")


func _on_attack_hit(target: Node2D) -> void:
	print("Attack hit: ", target.name)


func _on_player_damaged(amount: int) -> void:
	print("Player took ", amount, " damage! HP: ", player_health.current_hp, "/", player_health.max_hp)


func _on_player_died() -> void:
	print("Player died! Respawning...")
	throw_physics.recall()

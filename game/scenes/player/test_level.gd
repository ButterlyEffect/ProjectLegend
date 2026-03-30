extends Node2D
## Test level for movement and blade prototyping.
## Handles blade input routing to ThrowPhysics and TeleportExecutor.

@onready var player: CharacterBody2D = $Player
@onready var throw_physics: Node = $Player/BladePivot/Blade/ThrowPhysics
@onready var teleport_executor: Node = $Player/BladePivot/Blade/TeleportExecutor
@onready var kill_zone: Area2D = $KillZone


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


func _physics_process(_delta: float) -> void:
	# Blade throw input
	if Input.is_action_just_pressed("throw_blade") and throw_physics.is_held():
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


func _on_kill_zone_entered(body: Node2D) -> void:
	if body == player:
		player.respawn()


func _on_blade_embedded(pos: Vector2, surface: StringName) -> void:
	print("Blade embedded at ", pos, " in ", surface)


func _on_blade_recalled() -> void:
	print("Blade recalled")


func _on_teleport_succeeded(dest: Vector2) -> void:
	print("Teleported to ", dest)


func _on_teleport_failed(reason: StringName) -> void:
	print("Teleport failed: ", reason)

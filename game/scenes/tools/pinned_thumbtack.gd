extends Node2D
## A thumbtack pinned in the world. Currently only ground-pin (springboard)
## behavior; wall-pin platform behavior lands with the throw chunk (3.2c).
##
## Bounces the player upward on any contact (no velocity gate — landing,
## jumping onto, or even walking into the pin all trigger the bounce).
## A short placement grace prevents auto-bounce when the player places
## the pin under their own feet.

signal bounced(remaining_durability: int)
signal broke

@export var current_durability: int = 5
@export var launch_force: float = -340.0  # Negative y = up. Higher than jump (~-220)
@export var placement_grace_frames: int = 12  # ~200ms before first bounce can fire

@onready var bounce_area: Area2D = $BounceArea
var _grace_timer: int = 0


func _ready() -> void:
	_grace_timer = placement_grace_frames
	bounce_area.body_entered.connect(_on_body_entered)


func _physics_process(_delta: float) -> void:
	if _grace_timer > 0:
		_grace_timer -= 1


func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return
	if _grace_timer > 0:
		return
	body.velocity = Vector2(body.velocity.x, launch_force)
	current_durability -= 1
	bounced.emit(current_durability)
	if current_durability <= 0:
		broke.emit()
		queue_free()

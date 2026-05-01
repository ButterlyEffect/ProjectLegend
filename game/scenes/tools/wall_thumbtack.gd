extends Node2D
## A thumbtack pinned into a wall. The shelf sticks out along outward_normal
## and acts as a temporary platform the player can stand on. Durability
## decrements on each landing (matching pinned_thumbtack's per-bounce model);
## at zero, the platform breaks.

signal landed_on(remaining_durability: int)
signal broke

@export var current_durability: int = 5
@export var placement_grace_frames: int = 12  # ~200ms before first tick can fire

var outward_normal: Vector2 = Vector2.RIGHT  # set by thrown_thumbtack on spawn

@onready var shelf_body: StaticBody2D = $ShelfBody
@onready var shelf_shape: CollisionShape2D = $ShelfBody/CollisionShape2D
@onready var shelf_visual: ColorRect = $ShelfBody/Visual
@onready var landing_area: Area2D = $LandingArea
@onready var landing_shape: CollisionShape2D = $LandingArea/CollisionShape2D

const SHELF_LENGTH: float = 12.0
const SHELF_THICKNESS: float = 3.0

var _grace_timer: int = 0


func _ready() -> void:
	_grace_timer = placement_grace_frames
	_orient_shelf()
	landing_area.body_entered.connect(_on_landing)


func _physics_process(_delta: float) -> void:
	if _grace_timer > 0:
		_grace_timer -= 1


func _orient_shelf() -> void:
	# Shelf extends outward from the wall along outward_normal.
	# Shelf center sits half-a-shelf away from the wall surface so it doesn't clip.
	var dir: Vector2 = outward_normal.normalized()
	var center_offset: Vector2 = dir * (SHELF_LENGTH * 0.5)
	shelf_body.position = center_offset
	# Long axis is along the normal (horizontal for left/right walls, vertical otherwise).
	# We're scoped to wall hits, so outward_normal is mostly horizontal — rotate to match.
	shelf_body.rotation = dir.angle()
	# Landing detector sits just above the standable face of the shelf (in world up).
	# Place its center above the shelf center so it catches the player's feet.
	landing_area.position = center_offset + Vector2(0, -SHELF_THICKNESS)


func _on_landing(body: Node) -> void:
	if not body.is_in_group("player"):
		return
	if _grace_timer > 0:
		return
	current_durability -= 1
	landed_on.emit(current_durability)
	if current_durability <= 0:
		broke.emit()
		queue_free()

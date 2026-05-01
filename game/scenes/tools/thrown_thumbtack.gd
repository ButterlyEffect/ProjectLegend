extends Node2D
## A thumbtack mid-flight after a hold-aim throw. Raycasts each frame
## between previous and current world position to catch the surface hit
## (mirrors the blade throw model in scenes/player/blade/throw_physics.gd).
##
## On hit:
##   - Mostly-vertical normal (floor or ceiling) → spawn springboard pin (pinned_thumbtack)
##   - Mostly-horizontal normal (wall) → spawn wall_thumbtack platform
## At max range without a hit, the thumbtack simply despawns (durability spent).

const PINNED_THUMBTACK_SCENE := preload("res://scenes/tools/pinned_thumbtack.tscn")
const WALL_THUMBTACK_SCENE := preload("res://scenes/tools/wall_thumbtack.tscn")

@export var throw_speed: float = 180.0
@export var max_range: float = 80.0
@export var current_durability: int = 5

var _direction: Vector2 = Vector2.RIGHT
var _distance_traveled: float = 0.0
var _started: bool = false


func launch(direction: Vector2, durability: int) -> void:
	_direction = direction.normalized()
	current_durability = durability
	_started = true
	rotation = _direction.angle()


func _physics_process(delta: float) -> void:
	if not _started:
		return
	var movement: Vector2 = _direction * throw_speed * delta
	var prev_position: Vector2 = global_position
	var next_position: Vector2 = global_position + movement
	if _check_surface_hit(prev_position, next_position):
		return
	global_position = next_position
	_distance_traveled += movement.length()
	if _distance_traveled >= max_range:
		queue_free()


func _check_surface_hit(from_pos: Vector2, to_pos: Vector2) -> bool:
	var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(
		from_pos,
		to_pos,
		1  # Terrain mask
	)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	var result: Dictionary = space_state.intersect_ray(query)
	if result.is_empty():
		return false
	_anchor_at(result.position, result.normal)
	return true


func _anchor_at(hit_pos: Vector2, hit_normal: Vector2) -> void:
	if absf(hit_normal.y) > absf(hit_normal.x):
		_spawn_ground_pin(hit_pos, hit_normal)
	else:
		_spawn_wall_pin(hit_pos, hit_normal)
	queue_free()


func _spawn_ground_pin(hit_pos: Vector2, hit_normal: Vector2) -> void:
	var pin := PINNED_THUMBTACK_SCENE.instantiate()
	pin.current_durability = current_durability
	# Place pin sitting on the surface — nudge slightly along the normal
	pin.global_position = hit_pos + hit_normal * 1.0
	get_tree().current_scene.add_child(pin)


func _spawn_wall_pin(hit_pos: Vector2, hit_normal: Vector2) -> void:
	var pin := WALL_THUMBTACK_SCENE.instantiate()
	pin.current_durability = current_durability
	pin.outward_normal = hit_normal
	pin.global_position = hit_pos
	get_tree().current_scene.add_child(pin)

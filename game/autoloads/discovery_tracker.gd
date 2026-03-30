extends Node
## Tracks discovered rooms, unlocked recipes, and opened paths.
## Stub — full implementation in Epic 7.

signal room_discovered(room_id: StringName)
signal recipe_unlocked(recipe_id: StringName)

var discovered_rooms: Array[StringName] = []
var unlocked_recipes: Array[StringName] = []


func discover_room(room_id: StringName) -> void:
	if room_id not in discovered_rooms:
		discovered_rooms.append(room_id)
		room_discovered.emit(room_id)


func unlock_recipe(recipe_id: StringName) -> void:
	if recipe_id not in unlocked_recipes:
		unlocked_recipes.append(recipe_id)
		recipe_unlocked.emit(recipe_id)

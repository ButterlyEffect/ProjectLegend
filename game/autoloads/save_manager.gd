extends Node
## JSON save/load with atomic writes (NFR11).
## Minimal implementation for playtesting (Story 2.7). Full version in Epic 7.

const SAVE_PATH := "user://save_game.json"
const SAVE_TEMP := "user://save_game.tmp"
const SAVE_VERSION := 1

signal save_completed
signal load_completed


func save_game() -> bool:
	var data: Dictionary = {
		"version": SAVE_VERSION,
		"trust_stage": String(GameManager.current_trust_stage),
		"current_zone": String(GameManager.current_zone),
		"current_scene": get_tree().current_scene.scene_file_path,
		"play_time_seconds": 0,
	}
	var player: Node = get_tree().get_first_node_in_group("player")
	if player and player is Node2D:
		data["player_position"] = {
			"x": (player as Node2D).global_position.x,
			"y": (player as Node2D).global_position.y,
		}
	var json_string: String = JSON.stringify(data, "\t")
	# Atomic write: temp file → rename
	var file: FileAccess = FileAccess.open(SAVE_TEMP, FileAccess.WRITE)
	if file == null:
		push_warning("SaveManager: could not open temp file for writing")
		return false
	file.store_string(json_string)
	file.close()
	var err: Error = DirAccess.rename_absolute(
		ProjectSettings.globalize_path(SAVE_TEMP),
		ProjectSettings.globalize_path(SAVE_PATH)
	)
	if err != OK:
		push_warning("SaveManager: rename failed (err=%d)" % err)
		return false
	save_completed.emit()
	return true


func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return {}
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return {}
	var json_string: String = file.get_as_text()
	file.close()
	var json: JSON = JSON.new()
	var result: Error = json.parse(json_string)
	if result != OK:
		push_warning("SaveManager: corrupt save file, starting fresh")
		return {}
	load_completed.emit()
	return json.data


func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)


func apply_save_to_player(data: Dictionary, player: Node2D) -> bool:
	## Returns true if the save was applied to this scene's player.
	## Scene mismatch → returns false so caller can decide what to do.
	if data.is_empty():
		return false
	var saved_scene: String = data.get("current_scene", "")
	var current_scene: String = get_tree().current_scene.scene_file_path
	if saved_scene != current_scene:
		return false
	if data.has("trust_stage"):
		GameManager.current_trust_stage = StringName(data["trust_stage"])
	if data.has("current_zone"):
		GameManager.current_zone = StringName(data["current_zone"])
	if data.has("player_position") and player:
		var pos: Dictionary = data["player_position"]
		player.global_position = Vector2(pos.get("x", 0.0), pos.get("y", 0.0))
	return true

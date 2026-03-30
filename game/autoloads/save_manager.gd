extends Node
## JSON save/load with atomic writes.
## Minimal implementation for playtesting (Story 2.7). Full version in Epic 7.

const SAVE_PATH := "user://save_game.json"
const SAVE_TEMP := "user://save_game.tmp"

signal save_completed
signal load_completed


func save_game() -> void:
	var data: Dictionary = {
		"version": 1,
		"trust_stage": GameManager.current_trust_stage,
		"current_zone": GameManager.current_zone,
		"play_time_seconds": 0,
	}
	var json_string: String = JSON.stringify(data, "\t")
	# Atomic write: write to temp, then rename
	var file: FileAccess = FileAccess.open(SAVE_TEMP, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
		DirAccess.rename_absolute(
			ProjectSettings.globalize_path(SAVE_TEMP),
			ProjectSettings.globalize_path(SAVE_PATH)
		)
		save_completed.emit()


func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return {}
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return {}
	var json_string: String = file.get_as_text()
	file.close()
	var json: JSON = JSON.new()
	var result: Error = json.parse(json_string)
	if result != OK:
		push_warning("SaveManager: Corrupt save file, starting fresh")
		return {}
	load_completed.emit()
	return json.data


func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

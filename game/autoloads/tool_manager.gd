extends Node
## Singleton managing the player's tool inventory.
## Holds up to `max_inventory_slots` tools. One is active at a time.
## Story 3.1 scope: pickup + inventory tracking. Durability tick, swap,
## and tool use mechanics land in 3.2+.

signal tool_picked_up(tool_id: StringName)
signal tool_removed(tool_id: StringName)
signal inventory_full

const DATABASE_PATH := "res://resources/tool_definitions.tres"

@export var max_inventory_slots: int = 3

var database: ToolDatabase
# Each entry: { "id": StringName, "current_durability": int }
var inventory: Array[Dictionary] = []
var active_index: int = -1


func _ready() -> void:
	database = load(DATABASE_PATH) as ToolDatabase
	if database == null:
		push_warning("ToolManager: failed to load tool database at %s" % DATABASE_PATH)


func can_pickup() -> bool:
	return inventory.size() < max_inventory_slots


func add_tool(tool_id: StringName) -> bool:
	if not can_pickup():
		inventory_full.emit()
		return false
	var def: ToolDefinition = database.get_tool(tool_id) if database else null
	if def == null:
		push_warning("ToolManager: unknown tool id '%s'" % tool_id)
		return false
	inventory.append({"id": tool_id, "current_durability": def.max_durability})
	if active_index < 0:
		active_index = inventory.size() - 1
	tool_picked_up.emit(tool_id)
	return true


func remove_active_tool() -> void:
	if active_index < 0 or active_index >= inventory.size():
		return
	var removed_id: StringName = inventory[active_index]["id"]
	inventory.remove_at(active_index)
	if inventory.is_empty():
		active_index = -1
	else:
		active_index = clamp(active_index, 0, inventory.size() - 1)
	tool_removed.emit(removed_id)


func get_inventory() -> Array[Dictionary]:
	return inventory


func get_active_tool() -> Dictionary:
	if active_index < 0 or active_index >= inventory.size():
		return {}
	return inventory[active_index]


func cycle_active() -> void:
	if inventory.is_empty():
		active_index = -1
		return
	active_index = (active_index + 1) % inventory.size()


func get_definition(tool_id: StringName) -> ToolDefinition:
	return database.get_tool(tool_id) if database else null

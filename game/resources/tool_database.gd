class_name ToolDatabase
extends Resource
## Collection of all tool definitions. Looked up by ToolManager on _ready.

@export var tools: Array = []  # Array of ToolDefinition


func get_tool(id: StringName) -> ToolDefinition:
	for t in tools:
		var def: ToolDefinition = t as ToolDefinition
		if def and def.id == id:
			return def
	return null

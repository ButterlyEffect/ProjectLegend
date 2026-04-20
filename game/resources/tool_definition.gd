class_name ToolDefinition
extends Resource
## Static description of a tool type. One ToolDefinition per tool species
## (thumbtack, penny, yarn). Shared across all instances of that tool.

@export var id: StringName = &""
@export var display_name: String = ""
@export var max_durability: int = 10
@export var visual_color: Color = Color.WHITE
@export var description: String = ""

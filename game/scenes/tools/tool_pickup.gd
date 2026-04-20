extends Area2D
## World pickup for a tool. Player walks over → tool is added to inventory.
## Set `tool_id` in the editor (or when instancing) to pick which tool this is.

@export var tool_id: StringName = &"thumbtack"
@export var bob_amplitude: float = 2.0  # Small vertical bob for visibility
@export var bob_speed: float = 3.0

@onready var visual: ColorRect = $Visual
var _home_y: float = 0.0
var _time: float = 0.0


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_home_y = position.y
	# Color the visual from the tool definition
	var def: ToolDefinition = ToolManager.get_definition(tool_id)
	if def:
		visual.color = def.visual_color


func _process(delta: float) -> void:
	_time += delta
	position.y = _home_y + sin(_time * bob_speed) * bob_amplitude


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if ToolManager.add_tool(tool_id):
		queue_free()

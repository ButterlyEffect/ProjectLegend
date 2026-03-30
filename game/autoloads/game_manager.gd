extends Node
## Global game state and trust stage management.
## Single source of truth for trust stage — only this script mutates trust.

signal trust_stage_changed(new_stage: StringName)
signal game_state_changed(new_state: StringName)

const TRUST_STAGES: Array[StringName] = [
	&"useless", &"reluctant", &"willing", &"partnered",
	&"trusted", &"bonded", &"perfect_duo"
]

var blade_state: Resource  # BladeStateResource — set in _ready
var current_trust_stage: StringName = &"reluctant"
var current_zone: StringName = &"golden_glade"

# Trust stage parameter data — loaded from resource
var _trust_data: Dictionary = {
	&"reluctant":  {"throw_speed": 150.0, "landing_lag": 12, "teleport_speed": 300.0, "max_range": 200.0},
	&"willing":    {"throw_speed": 200.0, "landing_lag": 8,  "teleport_speed": 400.0, "max_range": 280.0},
	&"partnered":  {"throw_speed": 250.0, "landing_lag": 5,  "teleport_speed": 500.0, "max_range": 360.0},
	&"trusted":    {"throw_speed": 300.0, "landing_lag": 3,  "teleport_speed": 600.0, "max_range": 440.0},
	&"bonded":     {"throw_speed": 340.0, "landing_lag": 2,  "teleport_speed": 700.0, "max_range": 500.0},
	&"perfect_duo":{"throw_speed": 380.0, "landing_lag": 1,  "teleport_speed": 800.0, "max_range": 560.0},
}


func _ready() -> void:
	_apply_trust_stage(current_trust_stage)


func advance_trust() -> void:
	var idx: int = TRUST_STAGES.find(current_trust_stage)
	if idx < TRUST_STAGES.size() - 1:
		current_trust_stage = TRUST_STAGES[idx + 1]
		_apply_trust_stage(current_trust_stage)
		trust_stage_changed.emit(current_trust_stage)


func get_trust_params() -> Dictionary:
	return _trust_data.get(current_trust_stage, _trust_data[&"reluctant"])


func _apply_trust_stage(stage: StringName) -> void:
	# Update BladeStateResource if it exists
	if blade_state and blade_state.has_method("apply_trust_params"):
		blade_state.apply_trust_params(get_trust_params())

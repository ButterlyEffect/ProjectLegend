extends Node2D
## Blade emotional state machine — observes gameplay signals, drives visual/audio feedback.
## Stub for Epic 4. Basic structure in place, full implementation later.

signal emotional_state_changed(new_state: StringName)

const STATE_NEUTRAL := &"neutral"
const STATE_FEARFUL := &"fearful"
const STATE_PROUD := &"proud"
const STATE_EXCITED := &"excited"

var _current_state: StringName = STATE_NEUTRAL


func _ready() -> void:
	pass  # Will connect to gameplay signals in Epic 4


func get_emotional_state() -> StringName:
	return _current_state


func _change_state(new_state: StringName) -> void:
	if new_state == _current_state:
		return
	_current_state = new_state
	emotional_state_changed.emit(_current_state)

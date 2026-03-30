extends Node
## Controller abstraction layer.
## All gameplay systems read input through this manager's action names.
## Handles remapping and device detection.

signal input_device_changed(device_type: StringName)

const DEVICE_CONTROLLER := &"controller"
const DEVICE_KEYBOARD := &"keyboard"

var active_device: StringName = DEVICE_CONTROLLER
var _last_input_device: StringName = DEVICE_CONTROLLER


func _input(event: InputEvent) -> void:
	# Auto-detect input device changes
	var detected: StringName = _last_input_device
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		detected = DEVICE_CONTROLLER
	elif event is InputEventKey or event is InputEventMouseButton:
		detected = DEVICE_KEYBOARD

	if detected != _last_input_device:
		_last_input_device = detected
		active_device = detected
		input_device_changed.emit(active_device)


## Get 8-directional aim from left stick / d-pad / WASD.
## Returns Vector2.ZERO if no direction held, otherwise one of 8 normalized directions.
func get_aim_direction() -> Vector2:
	var raw: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	if raw.length() < 0.3:
		return Vector2.ZERO
	# Snap to 8 directions
	var angle: float = raw.angle()
	var snapped_angle: float = snapped(angle, PI / 4.0)
	return Vector2.from_angle(snapped_angle).normalized()


func is_using_controller() -> bool:
	return active_device == DEVICE_CONTROLLER

extends Node2D
## Parry subsystem. Handles frame-precise parry window, slow-mo feedback,
## magic stocking, and whiff recovery.
## Attach as child of the Player CharacterBody2D.

signal parry_succeeded(magic_gained: int, combo_count: int)
signal parry_failed

@export_group("Parry Window")
@export var parry_window_frames: int = 5  # Active parry frames at 60Hz (~83ms)
@export var recovery_frames: int = 18  # Vulnerable after whiff (~300ms)

@export_group("Slow Motion")
@export var slowmo_scale: float = 0.15  # Engine.time_scale during parry slow-mo
@export var slowmo_duration_frames: int = 30  # Duration at 60Hz (~500ms real)

@export_group("Magic")
@export var magic_per_parry: int = 1

# --- Node references ---
var _player: CharacterBody2D
var _parry_detector: Area2D
var _blade_throw_physics: Node
var _blade_visual: ColorRect
var _blade_original_color: Color
var _player_sprite: ColorRect
var _player_original_color: Color

# --- State ---
enum ParryState { INACTIVE, WINDOW_OPEN, SLOWMO, RECOVERY }
var _state: ParryState = ParryState.INACTIVE
var _window_timer: int = 0
var _recovery_timer: int = 0
var _slowmo_timer: int = 0
var _magic_stock: int = 0
var _combo_count: int = 0
var _combo_window_timer: int = 0
var _whiff_flash_timer: int = 0
@export var combo_window_frames: int = 120  # ~2s at 60Hz to chain parries


func _ready() -> void:
	_player = get_parent() as CharacterBody2D
	_parry_detector = _player.get_node("ParryDetector") as Area2D
	_parry_detector.monitoring = false
	_blade_throw_physics = _player.get_node("BladePivot/Blade/ThrowPhysics")
	_blade_visual = _blade_throw_physics.get_node("BladeVisual") as ColorRect
	_blade_original_color = _blade_visual.color
	_player_sprite = _player.get_node("Sprite2D") as ColorRect
	_player_original_color = _player_sprite.color


func _physics_process(_delta: float) -> void:
	_update_combo_timer()

	match _state:
		ParryState.INACTIVE:
			_try_parry()
		ParryState.WINDOW_OPEN:
			_update_parry_window()
		ParryState.SLOWMO:
			_update_slowmo()
		ParryState.RECOVERY:
			_update_recovery()


func _try_parry() -> void:
	if not Input.is_action_just_pressed("parry"):
		return
	if _player.is_attacking() or _player.is_sliding():
		return
	_state = ParryState.WINDOW_OPEN
	_window_timer = parry_window_frames
	_parry_detector.monitoring = true


func _update_parry_window() -> void:
	# Check for enemy attack areas overlapping the parry detector
	for area in _parry_detector.get_overlapping_areas():
		if _is_enemy_attack(area):
			_on_parry_success()
			return
	_window_timer -= 1
	if _window_timer <= 0:
		_on_parry_whiff()


func _on_parry_success() -> void:
	_parry_detector.monitoring = false
	_state = ParryState.SLOWMO
	_slowmo_timer = slowmo_duration_frames
	# Combo tracking
	if _combo_window_timer > 0:
		_combo_count += 1
	else:
		_combo_count = 1
	_combo_window_timer = combo_window_frames
	# Grant brief invincibility so contact damage doesn't hit
	_player._is_invincible = true
	# Slow-mo
	Engine.time_scale = slowmo_scale
	# Show blade flaring at player position during parry
	_blade_throw_physics.visible = true
	_blade_throw_physics.top_level = false
	_blade_visual.color = Color(1.0, 1.0, 0.6, 1.0)  # Bright yellow-white glow
	# Flash player sprite gold to reinforce the parry hit
	_player_sprite.color = Color(1.0, 0.9, 0.3, 1.0)
	# Stock magic
	_magic_stock += magic_per_parry
	parry_succeeded.emit(magic_per_parry, _combo_count)
	print("PARRY! Magic: ", _magic_stock, " Combo: ", _combo_count)


func _on_parry_whiff() -> void:
	_parry_detector.monitoring = false
	_state = ParryState.RECOVERY
	_recovery_timer = recovery_frames
	_whiff_flash_timer = 0
	# Dim player sprite to show vulnerability
	_player_sprite.color = Color(0.4, 0.4, 0.4, 1.0)
	parry_failed.emit()
	print("Parry whiffed!")


func _update_slowmo() -> void:
	_slowmo_timer -= 1
	if _slowmo_timer <= 0:
		Engine.time_scale = 1.0
		# Hide blade again if it's supposed to be held
		if _blade_throw_physics.is_held():
			_blade_throw_physics.visible = false
		_blade_visual.color = _blade_original_color
		_player_sprite.color = _player_original_color
		_player._is_invincible = false
		_state = ParryState.INACTIVE


func _update_recovery() -> void:
	# Flash between dim and normal to show vulnerability
	_whiff_flash_timer -= 1
	if _whiff_flash_timer <= 0:
		_whiff_flash_timer = 4  # Toggle every ~67ms
		if _player_sprite.color == _player_original_color:
			_player_sprite.color = Color(0.4, 0.4, 0.4, 1.0)
		else:
			_player_sprite.color = _player_original_color
	_recovery_timer -= 1
	if _recovery_timer <= 0:
		_player_sprite.color = _player_original_color
		_state = ParryState.INACTIVE


func _update_combo_timer() -> void:
	if _combo_window_timer > 0:
		_combo_window_timer -= 1
		if _combo_window_timer <= 0:
			_combo_count = 0


func _is_enemy_attack(area: Area2D) -> bool:
	# Enemy attack areas are on collision layer 64 (layer 7)
	return area.collision_layer & 64 != 0


func is_parrying() -> bool:
	return _state == ParryState.WINDOW_OPEN


func is_in_recovery() -> bool:
	return _state == ParryState.RECOVERY


func is_in_slowmo() -> bool:
	return _state == ParryState.SLOWMO


func get_magic_stock() -> int:
	return _magic_stock


func spend_magic(amount: int) -> bool:
	if _magic_stock >= amount:
		_magic_stock -= amount
		return true
	return false

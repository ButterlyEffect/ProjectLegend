extends Node2D
## Test level for movement and blade prototyping.
## Handles blade input routing to ThrowPhysics and TeleportExecutor.

@onready var player: CharacterBody2D = $Player
@onready var throw_physics: Node = $Player/BladePivot/Blade/ThrowPhysics
@onready var teleport_executor: Node = $Player/BladePivot/Blade/TeleportExecutor
@onready var parry_subsystem: Node = $Player/ParrySubsystem
@onready var player_health: Node = $Player/PlayerHealth
@onready var kill_zone: Area2D = $KillZone
@onready var moving_platform: AnimatableBody2D = $MovingPlatform

var _range_indicator: Line2D
var _platform_tween: Tween
var _magic_label: Label
var _save_label: Label
var _inventory_slots: Array[ColorRect] = []
var _inventory_borders: Array[ColorRect] = []
var _inventory_durability_labels: Array[Label] = []
var _pickup_toast: Label
var _blade_throw_cancelled: bool = false


func _ready() -> void:
	if kill_zone:
		kill_zone.body_entered.connect(_on_kill_zone_entered)
	_start_platform_loop()
	# Connect blade signals for debug feedback
	if throw_physics:
		throw_physics.blade_embedded.connect(_on_blade_embedded)
		throw_physics.blade_recalled.connect(_on_blade_recalled)
	if teleport_executor:
		teleport_executor.teleport_succeeded.connect(_on_teleport_succeeded)
		teleport_executor.teleport_failed.connect(_on_teleport_failed)
	# Connect attack signals
	player.attack_started.connect(_on_attack_started)
	player.attack_hit.connect(_on_attack_hit)
	# Connect health signals
	player_health.player_damaged.connect(_on_player_damaged)
	player_health.player_died.connect(_on_player_died)
	_range_indicator = Line2D.new()
	_range_indicator.top_level = true
	_range_indicator.width = 1.0
	_range_indicator.default_color = Color(1.0, 1.0, 0.6, 0.5)
	_range_indicator.visible = false
	add_child(_range_indicator)
	_setup_magic_counter()
	_setup_save_feedback()
	_setup_inventory_ui()
	ToolManager.tool_picked_up.connect(_on_tool_picked_up)
	ToolManager.inventory_full.connect(_on_inventory_full)
	ToolManager.tool_broke.connect(_on_tool_broke)
	ToolManager.tool_removed.connect(_on_tool_removed)
	ToolManager.tool_imbued.connect(_on_tool_imbued)
	# Auto-load any existing save and apply to player
	if SaveManager.has_save():
		var data: Dictionary = SaveManager.load_game()
		if SaveManager.apply_save_to_player(data, player):
			print("Loaded save at ", player.global_position, " trust=", GameManager.current_trust_stage)


func _setup_magic_counter() -> void:
	var ui := CanvasLayer.new()
	ui.layer = 50
	add_child(ui)
	_magic_label = Label.new()
	_magic_label.text = "Magic: 0"
	_magic_label.position = Vector2(8, 6)
	_magic_label.add_theme_font_size_override("font_size", 10)
	_magic_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.3, 1.0))
	_magic_label.add_theme_color_override("font_outline_color", Color.BLACK)
	_magic_label.add_theme_constant_override("outline_size", 4)
	ui.add_child(_magic_label)


func _setup_save_feedback() -> void:
	var ui := CanvasLayer.new()
	ui.layer = 51
	add_child(ui)
	_save_label = Label.new()
	_save_label.text = ""
	_save_label.add_theme_font_size_override("font_size", 7)
	_save_label.add_theme_color_override("font_color", Color(0.5, 1.0, 0.6, 1.0))
	_save_label.add_theme_color_override("font_outline_color", Color.BLACK)
	_save_label.add_theme_constant_override("outline_size", 3)
	# Anchor to bottom-right of the 480x270 viewport
	_save_label.anchor_left = 1.0
	_save_label.anchor_right = 1.0
	_save_label.anchor_top = 1.0
	_save_label.anchor_bottom = 1.0
	_save_label.offset_left = -42
	_save_label.offset_top = -14
	_save_label.offset_right = -4
	_save_label.offset_bottom = -2
	_save_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_save_label.modulate.a = 0.0
	ui.add_child(_save_label)


func _flash_save_feedback(text: String) -> void:
	_save_label.text = text
	_save_label.modulate.a = 1.0
	var tween := create_tween()
	tween.tween_interval(0.6)
	tween.tween_property(_save_label, "modulate:a", 0.0, 0.4)


func _setup_inventory_ui() -> void:
	var ui := CanvasLayer.new()
	ui.layer = 50
	add_child(ui)
	# Row of 3 slot squares in top-right of 480x270 viewport
	var slot_size: int = 8
	var spacing: int = 3
	var row_right: int = 472  # x=480 viewport - 8 margin
	var row_top: int = 6
	for i in range(ToolManager.max_inventory_slots):
		var x: int = row_right - (ToolManager.max_inventory_slots - i) * (slot_size + spacing) + spacing
		# Border (behind slot) — used as active indicator
		var border := ColorRect.new()
		border.position = Vector2(x - 1, row_top - 1)
		border.size = Vector2(slot_size + 2, slot_size + 2)
		border.color = Color(1.0, 0.85, 0.3, 0.0)  # gold, hidden until active
		ui.add_child(border)
		_inventory_borders.append(border)
		var slot := ColorRect.new()
		slot.position = Vector2(x, row_top)
		slot.size = Vector2(slot_size, slot_size)
		slot.color = Color(0.15, 0.15, 0.15, 0.7)  # empty-slot gray
		ui.add_child(slot)
		_inventory_slots.append(slot)
		# Durability number sits below the slot
		var dur := Label.new()
		dur.text = ""
		dur.add_theme_font_size_override("font_size", 6)
		dur.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 0.9))
		dur.add_theme_color_override("font_outline_color", Color.BLACK)
		dur.add_theme_constant_override("outline_size", 2)
		dur.position = Vector2(x - 1, row_top + slot_size + 1)
		dur.size = Vector2(slot_size + 2, 8)
		dur.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		ui.add_child(dur)
		_inventory_durability_labels.append(dur)
	# Pickup / inventory-full toast under the slots
	_pickup_toast = Label.new()
	_pickup_toast.text = ""
	_pickup_toast.add_theme_font_size_override("font_size", 7)
	_pickup_toast.add_theme_color_override("font_color", Color(1.0, 0.85, 0.3, 1.0))
	_pickup_toast.add_theme_color_override("font_outline_color", Color.BLACK)
	_pickup_toast.add_theme_constant_override("outline_size", 3)
	_pickup_toast.anchor_left = 1.0
	_pickup_toast.anchor_right = 1.0
	_pickup_toast.offset_left = -80
	_pickup_toast.offset_right = -4
	_pickup_toast.offset_top = 18
	_pickup_toast.offset_bottom = 30
	_pickup_toast.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_pickup_toast.modulate.a = 0.0
	ui.add_child(_pickup_toast)


func _refresh_inventory_ui() -> void:
	var inv: Array[Dictionary] = ToolManager.get_inventory()
	for i in range(_inventory_slots.size()):
		if i < inv.size():
			var def: ToolDefinition = ToolManager.get_definition(inv[i]["id"])
			_inventory_slots[i].color = def.visual_color if def else Color.WHITE
			_inventory_durability_labels[i].text = str(inv[i]["current_durability"])
		else:
			_inventory_slots[i].color = Color(0.15, 0.15, 0.15, 0.7)
			_inventory_durability_labels[i].text = ""
		# Active-slot indicator
		var is_active: bool = (i == ToolManager.active_index)
		_inventory_borders[i].color.a = 1.0 if is_active else 0.0


func _flash_pickup_toast(text: String, color: Color) -> void:
	_pickup_toast.text = text
	_pickup_toast.add_theme_color_override("font_color", color)
	_pickup_toast.modulate.a = 1.0
	var tween := create_tween()
	tween.tween_interval(0.8)
	tween.tween_property(_pickup_toast, "modulate:a", 0.0, 0.4)


func _on_tool_picked_up(tool_id: StringName) -> void:
	var def: ToolDefinition = ToolManager.get_definition(tool_id)
	var display: String = def.display_name if def else str(tool_id)
	_flash_pickup_toast("picked up: " + display.to_lower(), Color(0.6, 1.0, 0.6, 1.0))
	_refresh_inventory_ui()


func _on_inventory_full() -> void:
	_flash_pickup_toast("inventory full", Color(1.0, 0.5, 0.3, 1.0))


func _on_tool_broke(tool_id: StringName) -> void:
	var def: ToolDefinition = ToolManager.get_definition(tool_id)
	var display: String = def.display_name if def else str(tool_id)
	_flash_pickup_toast(display.to_lower() + " broke!", Color(1.0, 0.4, 0.4, 1.0))
	_refresh_inventory_ui()


func _on_tool_removed(tool_id: StringName) -> void:
	var def: ToolDefinition = ToolManager.get_definition(tool_id)
	var display: String = def.display_name if def else str(tool_id)
	_flash_pickup_toast("dropped: " + display.to_lower(), Color(0.8, 0.8, 0.8, 1.0))
	_refresh_inventory_ui()


func _on_tool_imbued(tool_id: StringName, restored_amount: int) -> void:
	var def: ToolDefinition = ToolManager.get_definition(tool_id)
	var display: String = def.display_name if def else str(tool_id)
	_flash_pickup_toast("imbued " + display.to_lower() + " +" + str(restored_amount), Color(1.0, 0.85, 0.3, 1.0))
	_pulse_active_slot()
	_refresh_inventory_ui()


func _pulse_active_slot() -> void:
	if ToolManager.active_index < 0 or ToolManager.active_index >= _inventory_slots.size():
		return
	var slot: ColorRect = _inventory_slots[ToolManager.active_index]
	var original: Color = slot.color
	slot.color = Color(1.0, 0.85, 0.3, 1.0)
	var tween := create_tween()
	tween.tween_property(slot, "color", original, 0.5)


func _physics_process(_delta: float) -> void:
	# Blade throw input — hold to aim, release to throw, slide (B) to cancel mid-aim
	if Input.is_action_just_pressed("throw_blade") and throw_physics.is_held():
		_blade_throw_cancelled = false
	if Input.is_action_pressed("throw_blade") and throw_physics.is_held():
		if _blade_aim_cancel_pressed():
			_blade_throw_cancelled = true
			_range_indicator.visible = false
	if Input.is_action_just_released("throw_blade") and throw_physics.is_held():
		var was_cancelled: bool = _blade_throw_cancelled
		_blade_throw_cancelled = false
		if not was_cancelled:
			var aim: Vector2 = InputManager.get_aim_direction_analog()
			if aim == Vector2.ZERO:
				aim = player.get_facing_direction()
			throw_physics.throw_blade(aim)

	# Teleport input
	if Input.is_action_just_pressed("teleport"):
		teleport_executor.try_teleport()

	# Recall input
	if Input.is_action_just_pressed("recall_blade"):
		throw_physics.recall()

	_update_range_indicator()
	_update_magic_counter()
	if Input.is_action_just_pressed("swap_tool"):
		ToolManager.cycle_active()
	if Input.is_action_just_pressed("drop_tool"):
		ToolManager.remove_active_tool()
	_refresh_inventory_ui()


func _blade_aim_cancel_pressed() -> bool:
	# Any "other action" pressed mid-aim cancels the pending blade throw.
	return (
		Input.is_action_just_pressed("slide")
		or Input.is_action_just_pressed("use_tool")
		or Input.is_action_just_pressed("attack")
		or Input.is_action_just_pressed("parry")
	)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_QUOTELEFT:
			var ok: bool = SaveManager.save_game()
			_flash_save_feedback("saved" if ok else "save failed")


func _update_magic_counter() -> void:
	if _magic_label and parry_subsystem:
		_magic_label.text = "Magic: " + str(parry_subsystem.get_magic_stock())


func _update_range_indicator() -> void:
	if not throw_physics.is_held() or not Input.is_action_pressed("throw_blade"):
		_range_indicator.visible = false
		return
	if _blade_throw_cancelled:
		_range_indicator.visible = false
		return
	var aim: Vector2 = InputManager.get_aim_direction_analog()
	if aim == Vector2.ZERO:
		aim = player.get_facing_direction()
	_range_indicator.visible = true
	_range_indicator.clear_points()
	_range_indicator.add_point(player.global_position)
	_range_indicator.add_point(player.global_position + aim * throw_physics.max_range)


func _on_kill_zone_entered(body: Node2D) -> void:
	if body == player:
		player.respawn()
		throw_physics.recall()
		player_health._reset()


func _on_blade_embedded(pos: Vector2, surface: StringName) -> void:
	print("Blade embedded at ", pos, " in ", surface)


func _on_blade_recalled() -> void:
	print("Blade recalled")


func _on_teleport_succeeded(dest: Vector2) -> void:
	print("Teleported to ", dest)


func _on_teleport_failed(reason: StringName) -> void:
	print("Teleport failed: ", reason)


func _on_attack_started() -> void:
	print("Attack swing!")


func _on_attack_hit(target: Node2D) -> void:
	print("Attack hit: ", target.name)


func _on_player_damaged(amount: int) -> void:
	print("Player took ", amount, " damage! HP: ", player_health.current_hp, "/", player_health.max_hp)


func _on_player_died() -> void:
	print("Player died! Respawning...")
	throw_physics.recall()


func _start_platform_loop() -> void:
	if not moving_platform:
		return
	_platform_tween = create_tween().set_loops().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_platform_tween.tween_property(moving_platform, "position:x", 350.0, 2.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	_platform_tween.tween_property(moving_platform, "position:x", 80.0, 2.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

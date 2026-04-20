extends CharacterBody2D
## Base class for ground enemies. Handles HP, gravity, knockback,
## floating damage numbers, and a StringName state machine framework.
## Subclasses implement specific behavior in _update_state / _enter_state.

signal damaged(amount: int)
signal enemy_died

@export var max_hp: int = 5
@export var gravity: float = 600.0
@export var max_fall_speed: float = 300.0
@export var knockback_force: float = 80.0
@export var body_damage: int = 1  # Passive contact damage when player touches the enemy body

var _current_state: StringName
var _current_hp: int
var _is_dead: bool = false


func _ready() -> void:
	_current_hp = max_hp


func _physics_process(delta: float) -> void:
	if _is_dead:
		return
	if not is_on_floor():
		velocity.y = min(velocity.y + gravity * delta, max_fall_speed)
	_update_state(delta)
	move_and_slide()
	_check_body_contact_damage()


func _check_body_contact_damage() -> void:
	if body_damage <= 0:
		return
	var contact_zone: Area2D = get_node_or_null("ContactZone") as Area2D
	if contact_zone == null:
		return
	for area in contact_zone.get_overlapping_areas():
		var target: Node = area.get_parent()
		var health: Node = target.get_node_or_null("PlayerHealth")
		if health and health.has_method("take_damage"):
			health.take_damage(body_damage, global_position)


func _update_state(_delta: float) -> void:
	pass


func _change_state(new_state: StringName) -> void:
	_exit_state(_current_state)
	_current_state = new_state
	_enter_state(new_state)


func _enter_state(_state: StringName) -> void:
	pass


func _exit_state(_state: StringName) -> void:
	pass


func take_damage(amount: int) -> void:
	if _is_dead:
		return
	_current_hp -= amount
	damaged.emit(amount)
	_spawn_damage_number(amount)
	_flash_hit()
	if _current_hp <= 0:
		_die()


func apply_knockback_from(source_position: Vector2) -> void:
	var dir: Vector2 = (global_position - source_position).normalized()
	if dir == Vector2.ZERO:
		dir = Vector2.LEFT
	velocity.x = dir.x * knockback_force
	velocity.y = -knockback_force * 0.4


func _flash_hit() -> void:
	var visual: ColorRect = get_node_or_null("Visual") as ColorRect
	if not visual:
		return
	var original: Color = visual.color
	visual.color = Color.WHITE
	await get_tree().create_timer(0.08).timeout
	if is_inside_tree() and not _is_dead:
		visual.color = original


func _die() -> void:
	_is_dead = true
	enemy_died.emit()
	visible = false
	var hurtbox: Area2D = get_node_or_null("Hurtbox") as Area2D
	if hurtbox:
		hurtbox.monitoring = false
		hurtbox.monitorable = false
	var damage_zone: Area2D = get_node_or_null("DamageZone") as Area2D
	if damage_zone:
		damage_zone.monitoring = false
		damage_zone.monitorable = false
	var contact_zone: Area2D = get_node_or_null("ContactZone") as Area2D
	if contact_zone:
		contact_zone.monitoring = false
		contact_zone.monitorable = false
	$CollisionShape2D.set_deferred("disabled", true)
	set_physics_process(false)


func _spawn_damage_number(amount: int) -> void:
	var label := Label.new()
	label.text = str(amount)
	label.z_index = 100
	var color := Color.WHITE
	if amount >= 3:
		color = Color(1.0, 0.35, 0.2, 1.0)
	elif amount >= 2:
		color = Color(1.0, 0.85, 0.3, 1.0)
	label.modulate = color
	label.add_theme_font_size_override("font_size", 14 + amount * 4)
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	label.add_theme_constant_override("outline_size", 4)
	var jitter := randf_range(-10.0, 10.0)
	label.position = global_position + Vector2(jitter - 6, -36)
	get_tree().current_scene.add_child(label)
	var rise_to: float = label.position.y - 28
	var tween := create_tween().set_parallel(true)
	tween.tween_property(label, "position:y", rise_to, 0.6).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "modulate:a", 0.0, 0.5).set_delay(0.2)
	tween.chain().tween_callback(label.queue_free)


func is_dead() -> bool:
	return _is_dead


func get_current_hp() -> int:
	return _current_hp

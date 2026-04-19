extends StaticBody2D
## Training target with visible attack cycle for parry testing.
## Swings an attack arm outward: IDLE → TELEGRAPH → SWING → COOLDOWN.
## The AttackArm ColorRect shows exactly where and when the hit lands.

signal damaged(amount: int)
signal destroyed

@export var max_hp: int = 3
@export var contact_damage: int = 1
@export var respawn_delay: float = 2.0

@export_group("Attack Cycle")
@export var idle_frames: int = 90  # ~1.5s at 60Hz
@export var telegraph_frames: int = 30  # ~0.5s wind-up
@export var swing_frames: int = 20  # ~0.33s active damage
@export var cooldown_frames: int = 30  # ~0.5s recovery

enum AttackPhase { IDLE, TELEGRAPH, SWING, COOLDOWN }

var _current_hp: int
var _original_color: Color
var _phase: AttackPhase = AttackPhase.IDLE
var _phase_timer: int = 0
var _telegraph_flash_timer: int = 0


func _ready() -> void:
	_current_hp = max_hp
	_original_color = $Visual.color
	$DamageZone.monitoring = false
	$DamageZone.monitorable = false
	$AttackArm.visible = false
	_enter_phase(AttackPhase.IDLE)


func _physics_process(_delta: float) -> void:
	match _phase:
		AttackPhase.IDLE:
			_update_idle()
		AttackPhase.TELEGRAPH:
			_update_telegraph()
		AttackPhase.SWING:
			_update_swing()
		AttackPhase.COOLDOWN:
			_update_cooldown()


func _update_idle() -> void:
	_phase_timer -= 1
	if _phase_timer <= 0:
		_enter_phase(AttackPhase.TELEGRAPH)


func _update_telegraph() -> void:
	# Flash the attack arm to warn the player
	_telegraph_flash_timer -= 1
	if _telegraph_flash_timer <= 0:
		_telegraph_flash_timer = 6
		$AttackArm.visible = not $AttackArm.visible
	_phase_timer -= 1
	if _phase_timer <= 0:
		_enter_phase(AttackPhase.SWING)


func _update_swing() -> void:
	# Active attack — deal contact damage via polling
	for area in $DamageZone.get_overlapping_areas():
		var player: Node = area.get_parent()
		var health: Node = player.get_node_or_null("PlayerHealth")
		if health and health.has_method("take_damage"):
			health.take_damage(contact_damage, global_position)
	_phase_timer -= 1
	if _phase_timer <= 0:
		_enter_phase(AttackPhase.COOLDOWN)


func _update_cooldown() -> void:
	_phase_timer -= 1
	if _phase_timer <= 0:
		_enter_phase(AttackPhase.IDLE)


func _enter_phase(phase: AttackPhase) -> void:
	_phase = phase
	match phase:
		AttackPhase.IDLE:
			_phase_timer = idle_frames
			$DamageZone.monitoring = false
			$DamageZone.monitorable = false
			$AttackArm.visible = false
			$Visual.color = _original_color
		AttackPhase.TELEGRAPH:
			_phase_timer = telegraph_frames
			_telegraph_flash_timer = 6
			$DamageZone.monitoring = false
			$DamageZone.monitorable = false
			# Arm shown as faded warning — flashes on/off
			$AttackArm.color = Color(1.0, 0.6, 0.0, 0.4)
			$AttackArm.visible = true
		AttackPhase.SWING:
			_phase_timer = swing_frames
			$DamageZone.monitoring = true
			$DamageZone.monitorable = true
			# Arm goes solid bright red — this is the danger
			$AttackArm.color = Color(1.0, 0.15, 0.15, 0.9)
			$AttackArm.visible = true
			$Visual.color = Color(1.0, 0.15, 0.15, 1.0)
		AttackPhase.COOLDOWN:
			_phase_timer = cooldown_frames
			$DamageZone.monitoring = false
			$DamageZone.monitorable = false
			$AttackArm.visible = false
			$Visual.color = Color(0.5, 0.2, 0.2, 1.0)


func take_damage(amount: int) -> void:
	_current_hp -= amount
	damaged.emit(amount)
	_spawn_damage_number(amount)
	_flash_hit()
	if _current_hp <= 0:
		_die()


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


func _flash_hit() -> void:
	$Visual.color = Color.WHITE
	await get_tree().create_timer(0.08).timeout
	if is_inside_tree():
		$Visual.color = _original_color


func _die() -> void:
	destroyed.emit()
	print("DummyTarget destroyed!")
	visible = false
	$Hurtbox.monitoring = false
	$Hurtbox.monitorable = false
	$DamageZone.monitoring = false
	$AttackArm.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	_enter_phase(AttackPhase.IDLE)
	await get_tree().create_timer(respawn_delay).timeout
	if is_inside_tree():
		_respawn()


func _respawn() -> void:
	_current_hp = max_hp
	visible = true
	$Hurtbox.monitoring = true
	$Hurtbox.monitorable = true
	$CollisionShape2D.set_deferred("disabled", false)
	$Visual.color = _original_color
	_enter_phase(AttackPhase.IDLE)
	print("DummyTarget respawned!")

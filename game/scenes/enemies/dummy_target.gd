extends StaticBody2D
## Simple training target for testing melee attacks.
## Takes damage, flashes, and respawns after being destroyed.

signal damaged(amount: int)
signal destroyed

@export var max_hp: int = 3
@export var contact_damage: int = 1
@export var respawn_delay: float = 2.0

var _current_hp: int
var _original_color: Color


func _ready() -> void:
	_current_hp = max_hp
	_original_color = $Visual.color


func _physics_process(_delta: float) -> void:
	for area in $DamageZone.get_overlapping_areas():
		var player: Node = area.get_parent()
		var health: Node = player.get_node_or_null("PlayerHealth")
		if health and health.has_method("take_damage"):
			health.take_damage(contact_damage, global_position)


func take_damage(amount: int) -> void:
	_current_hp -= amount
	damaged.emit(amount)
	print("DummyTarget hit! HP: ", _current_hp, "/", max_hp)
	_flash_hit()
	if _current_hp <= 0:
		_die()


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
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(respawn_delay).timeout
	if is_inside_tree():
		_respawn()


func _respawn() -> void:
	_current_hp = max_hp
	visible = true
	$Hurtbox.monitoring = true
	$Hurtbox.monitorable = true
	$DamageZone.monitoring = true
	$CollisionShape2D.set_deferred("disabled", false)
	$Visual.color = _original_color
	print("DummyTarget respawned!")

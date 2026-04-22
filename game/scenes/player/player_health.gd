extends Node2D
## Player health component. Manages HP, i-frames, damage flash, knockback, and death.
## Attach as child of the Player CharacterBody2D.

signal player_damaged(amount: int)
signal player_died

@export var max_hp: int = 5
@export var iframes_duration: float = 1.0  # Seconds of invincibility after hit
@export var knockback_force: float = 150.0
@export var flash_interval: float = 0.08  # Seconds between flash toggles during i-frames

var current_hp: int
var _iframes_timer: float = 0.0
var _flash_timer: float = 0.0
var _player: CharacterBody2D
var _sprite: ColorRect
var _original_color: Color


func _ready() -> void:
	_player = get_parent() as CharacterBody2D
	_sprite = _player.get_node("Sprite2D") as ColorRect
	_original_color = _sprite.color
	current_hp = max_hp


func _physics_process(delta: float) -> void:
	if _iframes_timer > 0.0:
		_iframes_timer -= delta
		_flash_timer -= delta
		if _flash_timer <= 0.0:
			_sprite.visible = not _sprite.visible
			_flash_timer = flash_interval
		if _iframes_timer <= 0.0:
			_sprite.visible = true
			_sprite.color = _original_color
			_player._is_invincible = false


func take_damage(amount: int, damage_source_position: Vector2) -> void:
	if _player.is_invincible():
		return
	# Race fix: if the parry window opened on the SAME frame as the enemy's
	# damage check, _is_invincible may not be set yet depending on physics
	# process order. Block damage if the parry window is currently open.
	var parry: Node = _player.get_node_or_null("ParrySubsystem")
	if parry and parry.has_method("is_parrying") and parry.is_parrying():
		return
	current_hp = max(current_hp - amount, 0)
	player_damaged.emit(amount)
	print("Player hit! HP: ", current_hp, "/", max_hp)
	# Break the parry combo — flow state is interrupted by taking damage
	if parry and parry.has_method("reset_combo"):
		parry.reset_combo()
	# i-frames
	_iframes_timer = iframes_duration
	_flash_timer = flash_interval
	_player._is_invincible = true
	_sprite.color = Color(1.0, 0.3, 0.3, 1.0)
	# Knockback away from damage source
	var knockback_dir: Vector2 = (_player.global_position - damage_source_position).normalized()
	if knockback_dir == Vector2.ZERO:
		knockback_dir = _player.get_facing_direction() * -1.0
	_player.apply_knockback(knockback_dir * knockback_force)
	# Death check
	if current_hp <= 0:
		_die()


func _die() -> void:
	player_died.emit()
	print("Player died!")
	# Freeze briefly so death is visible
	_player.set_physics_process(false)
	_sprite.visible = true
	_sprite.color = Color(1.0, 0.0, 0.0, 1.0)
	_iframes_timer = 0.0
	_player._is_invincible = true
	await get_tree().create_timer(0.5).timeout
	_player.set_physics_process(true)
	_reset()
	_player.respawn()


func _reset() -> void:
	current_hp = max_hp
	_iframes_timer = 0.0
	_sprite.visible = true
	_sprite.color = _original_color
	_player._is_invincible = false


func heal(amount: int) -> void:
	current_hp = min(current_hp + amount, max_hp)

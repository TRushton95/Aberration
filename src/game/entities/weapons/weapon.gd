extends StaticBody2D
class_name Weapon

signal fired

@export var _owner : Player
@export var _cooldown_s : float = 1.0

var _cooldown_timer : Timer = Timer.new()
var _is_on_cooldown : bool = false


func _on_cooldown_timer_timeout() -> void:
	_is_on_cooldown = false


func _ready() -> void:
	_cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	_cooldown_timer.autostart = false
	_cooldown_timer.one_shot = true
	add_child(_cooldown_timer)


func fire() -> void:
	if _is_on_cooldown:
		return
		
	_is_on_cooldown = true
	_cooldown_timer.start(_cooldown_s)
	fired.emit()

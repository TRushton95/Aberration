extends Entity
class_name Enemy

@export var _damage : int = 20

@onready var _attack_cooldown_timer : Timer = $AttackCooldownTimer

var _colliding_player : Player


func _on_attack_cooldown_timer_timeout() -> void:
	if _colliding_player != null:
		_colliding_player.get_health_vital().remove(_damage)
		_attack_cooldown_timer.start()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if !body is Player:
		return
		
	_colliding_player = body as Player
	
	if _attack_cooldown_timer.is_stopped():
		_colliding_player.get_health_vital().remove(_damage)
		_attack_cooldown_timer.start()


func _on_hurtbox_body_exited(body: Node2D) -> void:
	_colliding_player = null


func _on_health_vital_value_changed(value: float) -> void:
	print(_health_vital.get_display_string())


func _on_health_vital_empty() -> void:
	print("Enemy killed!")
	queue_free()

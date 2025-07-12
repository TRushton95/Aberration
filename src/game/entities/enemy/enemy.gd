extends Entity
class_name Enemy

const MOVE_SPEED : float = 200.0

@export var _damage : int = 20

@onready var _attack_cooldown_timer : Timer = $AttackCooldownTimer

var _colliding_player : Player
var _target : Player


func _on_aggro_area_body_entered(body: Node2D) -> void:
	if body is Player:
		_target = body


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


func _on_health_vital_empty() -> void:
	queue_free()


func _process(delta: float) -> void:
	if _target == null:
		return
		
	var direction : Vector2 = position.direction_to(_target.position)
	velocity = direction * MOVE_SPEED
	move_and_slide()

extends CharacterBody2D
class_name Entity

@export var _move_speed : float = 300.0
@export var _health_vital : HealthVital


func get_move_speed() -> float:
	return _move_speed


func get_health_vital() -> HealthVital:
	return _health_vital

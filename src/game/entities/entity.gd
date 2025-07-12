extends CharacterBody2D
class_name Entity

@export var _move_speed : float = 300.0
@export var _health_vital : HealthVital
@export var _health_bar : ProgressBar


func _on_health_vital_max_value_changed(value: float) -> void:
	_health_bar.max_value = value


func _on_health_vital_value_changed(value: float) -> void:
	_health_bar.value = value


func _ready() -> void:
	_health_vital.max_value_changed.connect(_on_health_vital_max_value_changed)
	_health_vital.value_changed.connect(_on_health_vital_value_changed)


func get_move_speed() -> float:
	return _move_speed


func get_health_vital() -> HealthVital:
	return _health_vital

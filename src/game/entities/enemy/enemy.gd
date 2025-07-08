extends Entity
class_name Enemy


func _on_health_vital_value_changed(value: float) -> void:
	print(_health_vital.get_display_string())


func _on_health_vital_empty() -> void:
	print("Enemy killed!")
	queue_free()

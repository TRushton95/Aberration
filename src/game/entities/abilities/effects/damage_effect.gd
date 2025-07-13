extends Effect
class_name DamageEffect

@export var _value : int = 20


func _internal_execute(_player: Player, target: Variant) -> void:
	if target is not Entity || target == null:
		return
		
	target.get_health_vital().remove(_value)

extends Resource
class_name Target


func get_target_type() -> Enums.TargetType:
	return _internal_get_target_type()


func validate(target: Variant) -> bool:
	return _internal_validate(target)


func _internal_get_target_type() -> Enums.TargetType:
	return Enums.TargetType.UNSET


func _internal_validate(_target: Variant) -> bool:
	return false

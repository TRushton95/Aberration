extends Target
class_name SelfTarget


func _internal_get_target_type() -> Enums.TargetType:
	return Enums.TargetType.SELF


func _internal_validate(target: Variant) -> bool:
	return target is Player

extends Target
class_name GroundTargetType


func _internal_get_target_type() -> Enums.TargetType:
	return Enums.TargetType.GROUND


func _internal_validate(target: Variant) -> bool:
	return target is Vector2

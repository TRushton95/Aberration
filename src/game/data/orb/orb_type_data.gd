extends Resource
class_name OrbTypeData

@export var _type_id : TypeIds.Orb = TypeIds.Orb.UNSET
@export var _display_name : String = ""


func get_type_id() -> TypeIds.Orb:
	return _type_id


func get_display_name() -> String:
	return _display_name

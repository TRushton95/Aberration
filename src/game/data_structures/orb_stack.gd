extends RefCounted
class_name OrbStack

var _orb_type_id : TypeIds.Orb
var _quantity : int


func _init(orb_type_id: TypeIds.Orb, quantity: int) -> void:
	_orb_type_id = orb_type_id
	_quantity = quantity if quantity >= 0 else 0


func add_quantity(quantity: int) -> void:
	_quantity += quantity


func remove_quantity(quantity: int) -> void:
	_quantity -= quantity
	
	if _quantity < 0:
		_quantity = 0


func get_orb_type_id() -> TypeIds.Orb:
	return _orb_type_id


func get_quantity() -> int:
	return _quantity

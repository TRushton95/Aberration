extends RefCounted
class_name OrbCollection

var _data : Dictionary[TypeIds.Orb, OrbStack] = {}


func add(type_id: TypeIds.Orb, quantity: int) -> void:
	if _data.has(type_id):
		_data[type_id].add_quantity(quantity)
	else:
		_data[type_id] = OrbStack.new(type_id, quantity)


func remove(type_id: TypeIds.Orb, quantity: int) -> void:
	if !_data.has(type_id):
		return
		
	_data[type_id].remove_quantity(quantity)
	
	if _data[type_id].get_quantity() == 0:
		_data.erase(type_id)


func get_by_id(type_id: TypeIds.Orb) -> OrbStack:
	var result : OrbStack = null
	
	if _data.has(type_id):
		result = _data[type_id]
		
	return result


func get_all() -> Dictionary[TypeIds.Orb, OrbStack]:
	return _data

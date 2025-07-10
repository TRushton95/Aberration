extends Resource
class_name OrbCollection

@export var _data : Dictionary[TypeIds.Orb, int] = {}


func add_quantity(type_id: TypeIds.Orb, quantity: int) -> void:
	if _data.has(type_id):
		_data[type_id] += quantity
	else:
		_data[type_id] = quantity


func remove_quantity(type_id: TypeIds.Orb, quantity: int) -> void:
	if !_data.has(type_id):
		return
		
	_data[type_id] -= quantity
	
	if _data[type_id] <= 0:
		_data.erase(type_id)


func get_quantity(type_id: TypeIds.Orb) -> int:
	var result : int = 0
	
	if _data.has(type_id):
		result = _data[type_id]
		
	return result


func get_data() -> Dictionary[TypeIds.Orb, int]:
	return _data


func add(b: OrbCollection) -> void:
	var b_data : Dictionary[TypeIds.Orb, int] = b.get_data()
	
	for orb_type_id in b_data.keys():
		add_quantity(orb_type_id, b_data[orb_type_id])

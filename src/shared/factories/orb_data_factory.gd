extends Node
class_name OrbDataFactory

const ORB_DATA_PATH_FORMAT : String = "res://shared/data/orb/%s.tres"

static var _orb_type_data_file_name_lookup : Dictionary[TypeIds.Orb, String] = {
	TypeIds.Orb.FIRE: "fire_orb",
	TypeIds.Orb.ICE: "ice_orb"
}

static var _cache : Dictionary[TypeIds.Orb, OrbTypeData] = {}


static func get_orb_data(type_id: TypeIds.Orb) -> OrbTypeData:
	if _cache.has(type_id):
		return _cache[type_id]
		
	if !_orb_type_data_file_name_lookup.has(type_id):
		return null
		
	var orb_type_data_file_name : String = _orb_type_data_file_name_lookup[type_id]
	var orb_type_data_path : String = ORB_DATA_PATH_FORMAT % [ orb_type_data_file_name ]
	
	var result : OrbTypeData = load(orb_type_data_path) as OrbTypeData
	_cache[type_id] = result
	
	return result


static func get_orb_name(type_id: TypeIds.Orb) -> String:
	var result : String = "None"
	
	var orb_data : OrbTypeData = get_orb_data(type_id)
	if orb_data != null:
		result = orb_data.get_display_name()
		
	return result

extends Node
class_name OrbFactory

const ORB_PATH_FORMAT : String = "res://shared/data/orb/%s.tres"

static var _orb_file_name_lookup : Dictionary[TypeIds.Orb, String] = {
	TypeIds.Orb.FIRE: "fire_orb",
	TypeIds.Orb.ICE: "ice_orb"
}

static var _cache : Dictionary[TypeIds.Orb, Orb] = {}


static func build(type_id: TypeIds.Orb) -> Orb:
	if _cache.has(type_id):
		return _cache[type_id]
		
	if !_orb_file_name_lookup.has(type_id):
		return null
		
	var orb_type_data_file_name : String = _orb_file_name_lookup[type_id]
	var orb_path : String = ORB_PATH_FORMAT % [ orb_type_data_file_name ]
	
	var result : Orb = load(orb_path).instantiate() as Orb
	_cache[type_id] = result
	
	return result

extends Resource
class_name SaveData

@export var _level: int = 1
@export var _orb_collection : OrbCollection
@export var _loadout : Loadout


func setup(level: int, orb_collection: OrbCollection, loadout: Loadout) -> void:
	_level = level
	_orb_collection = orb_collection
	_loadout = loadout


func get_level() -> int:
	return _level


func get_orb_collection() -> OrbCollection:
	return _orb_collection


func get_loadout() -> Loadout:
	return _loadout

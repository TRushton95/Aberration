extends Node2D
class_name Game

signal level_finished(level: int, orb_collection: OrbCollection)
signal player_died

@onready var _game_ui : GameUI = $GameUI
@onready var _player : Player = $Player

var _level : int = 1
var _orb_collection : OrbCollection = OrbCollection.new()


func _on_player_died() -> void:
	player_died.emit()


func _on_level_exit_player_entered() -> void:
	level_finished.emit(_level, _orb_collection)


func _on_player_picked_up_orb(type_id: TypeIds.Orb) -> void:
	_orb_collection.add_quantity(type_id, 1)
	_game_ui.set_orb_container_data(_orb_collection.get_data())


func _ready() -> void:
	set_orb_name_debug_labels()


func setup(level: int, loadout: Loadout) -> void:
	_level = level
	_game_ui.set_level(_level)
	_player.set_loadout(loadout)
	print("Loadout:\n%s" % loadout.get_display_string())


func set_orb_name_debug_labels() -> void:
	var head_orb : Orb = _player.get_orb_slot(Enums.OrbSlot.HEAD)
	var chest_orb : Orb = _player.get_orb_slot(Enums.OrbSlot.CHEST)
	var hands_orb : Orb = _player.get_orb_slot(Enums.OrbSlot.HANDS)
	var legs_orb : Orb = _player.get_orb_slot(Enums.OrbSlot.LEGS)
	
	var head : String = head_orb.get_display_name() if head_orb != null else "None"
	var chest : String = chest_orb.get_display_name() if chest_orb != null else "None"
	var hands : String = hands_orb.get_display_name() if hands_orb != null else "None"
	var legs : String = legs_orb.get_display_name() if legs_orb != null else "None"
	
	_game_ui.set_orb_names(head, chest, hands, legs)

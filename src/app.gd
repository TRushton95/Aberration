extends Node
class_name App

enum AppState { LOBBY, GAME }

@export var _main_menu_scene : PackedScene
@export var _game_scene : PackedScene
@export var _lobby_scene : PackedScene

var _app_state : Node


func _on_lobby_start_game_button_pressed() -> void:
	_go_to_game_state()


func _on_lobby_delete_save_button_pressed() -> void:
	var loadout : Loadout = Loadout.new()
	var orb_collection : OrbCollection = OrbCollection.new()
	
	ResourceSaver.save(loadout, Constants.SaveData.LOADOUT)
	ResourceSaver.save(orb_collection, Constants.SaveData.ORB_COLLECTION)
	
	if _app_state is Lobby:
		(_app_state as Lobby).set_data(loadout, orb_collection)


func _on_game_level_finished(gathered_orb_collection: OrbCollection) -> void:
	var orb_collection : OrbCollection = load(Constants.SaveData.ORB_COLLECTION) as OrbCollection
	
	if orb_collection == null:
		orb_collection = gathered_orb_collection
	else:
		orb_collection.add(gathered_orb_collection)
		
	var loadout : Loadout = load(Constants.SaveData.LOADOUT) as Loadout
	if loadout == null:
		loadout = Loadout.new()
		
	ResourceSaver.save(orb_collection, Constants.SaveData.ORB_COLLECTION)
	ResourceSaver.save(loadout, Constants.SaveData.LOADOUT)
	
	_go_to_lobby(loadout, orb_collection)


func _ready() -> void:
	var saved_loadout : Loadout = load(Constants.SaveData.LOADOUT) as Loadout
	var saved_orb_collection : OrbCollection = load(Constants.SaveData.ORB_COLLECTION) as OrbCollection
	
	_go_to_lobby(saved_loadout, saved_orb_collection)


func _go_to_lobby(loadout: Loadout, gathered_orb_collection: OrbCollection) -> void:
	var lobby_state : Lobby = _lobby_scene.instantiate() as Lobby
	lobby_state.start_game_button_pressed.connect(_on_lobby_start_game_button_pressed)
	lobby_state.delete_save_button_pressed.connect(_on_lobby_delete_save_button_pressed)
	
	_switch_app_state(lobby_state)
	lobby_state.set_data(loadout, gathered_orb_collection)


func _go_to_game_state() -> void:
	var game_state : Game = _game_scene.instantiate() as Game
	game_state.level_finished.connect(_on_game_level_finished)
	
	_switch_app_state(game_state)


func _switch_app_state(next_app_state: Node) -> void:
	if _app_state != null:
		_app_state.queue_free()
		
	_app_state = next_app_state
	
	if _app_state != null:
		add_child(_app_state)

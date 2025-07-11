extends Node
class_name App

enum AppState { LOBBY, GAME }

@export var _game_scene : PackedScene
@export var _lobby_scene : PackedScene

var _app_state : Node


func _on_lobby_start_game_button_pressed() -> void:
	_go_to_game_state()


func _on_game_level_finished(orb_collection: OrbCollection) -> void:
	var save_data : OrbCollection = load(Constants.SaveData.ORB_COLLECTION) as OrbCollection
	
	if save_data == null:
		save_data = orb_collection
	else:
		save_data.add(orb_collection)
		
	ResourceSaver.save(save_data, Constants.SaveData.ORB_COLLECTION)
	
	_go_to_lobby(save_data)


func _ready() -> void:
	var save_data : OrbCollection = load(Constants.SaveData.ORB_COLLECTION) as OrbCollection
	_go_to_lobby(save_data)


func _go_to_lobby(gathered_orb_collection: OrbCollection) -> void:
	var lobby_state : Lobby = _lobby_scene.instantiate() as Lobby
	lobby_state.start_game_button_pressed.connect(_on_lobby_start_game_button_pressed)
	
	_switch_app_state(lobby_state)
	lobby_state.setup(gathered_orb_collection)


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

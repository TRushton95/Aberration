extends Node
class_name App

enum AppState { LOBBY, GAME }

@export var _main_menu_scene : PackedScene
@export var _game_scene : PackedScene
@export var _lobby_scene : PackedScene

var _app_state : Node


func _on_game_player_died() -> void:
	get_tree().quit()


func _on_lobby_start_game_button_pressed(loadout: Loadout) -> void:
	_go_to_game_state(loadout)


func _on_lobby_delete_save_button_pressed() -> void:
	var loadout : Loadout = Loadout.new()
	var orb_collection : OrbCollection = OrbCollection.new()
	
	_save_game_state(1, orb_collection, loadout)
	
	if _app_state is Lobby:
		(_app_state as Lobby).set_data(loadout, orb_collection)


func _on_game_level_finished(level: int, gathered_orb_collection: OrbCollection) -> void:
	var save_data : SaveData = _load_game_state()
	if save_data == null:
		push_error("Save corrupt")
		return
		
	var orb_collection : OrbCollection = save_data.get_orb_collection()
	
	if orb_collection == null:
		orb_collection = gathered_orb_collection
	else:
		orb_collection.add(gathered_orb_collection)
		
	_save_game_state(level + 1, orb_collection, save_data.get_loadout())
	
	_go_to_lobby(save_data.get_loadout(), orb_collection)


func _ready() -> void:
	var save_data : SaveData = _load_game_state()
	if save_data == null:
		save_data = _save_game_state(1, OrbCollection.new(), Loadout.new())
		
	_go_to_lobby(save_data.get_loadout(), save_data.get_orb_collection())


func _go_to_lobby(loadout: Loadout, gathered_orb_collection: OrbCollection) -> void:
	var lobby_state : Lobby = _lobby_scene.instantiate() as Lobby
	lobby_state.start_game_button_pressed.connect(_on_lobby_start_game_button_pressed)
	lobby_state.delete_save_button_pressed.connect(_on_lobby_delete_save_button_pressed)
	
	_switch_app_state(lobby_state)
	lobby_state.set_data(loadout, gathered_orb_collection)


func _go_to_game_state(loadout: Loadout) -> void:
	var game_state : Game = _game_scene.instantiate() as Game
	game_state.level_finished.connect(_on_game_level_finished)
	game_state.player_died.connect(_on_game_player_died)
	
	var save_data : SaveData = _load_game_state()
	
	_switch_app_state(game_state)
	game_state.setup(save_data.get_level(), loadout)


func _switch_app_state(next_app_state: Node) -> void:
	if _app_state != null:
		_app_state.queue_free()
		
	_app_state = next_app_state
	
	if _app_state != null:
		add_child(_app_state)


func _save_game_state(level: int, orb_collection: OrbCollection, loadout: Loadout) -> SaveData:
	var save_data : SaveData = SaveData.new()
	save_data.setup(level, orb_collection, loadout)
	ResourceSaver.save(save_data, Constants.SAVE_DATA_PATH)
	
	return save_data


func _load_game_state() -> SaveData:
	var result : SaveData = null
	
	if ResourceLoader.exists(Constants.SAVE_DATA_PATH):
		result = load(Constants.SAVE_DATA_PATH) as SaveData
		
	return result

extends PanelContainer
class_name Lobby

signal start_game_button_pressed
signal delete_save_button_pressed

@onready var _orb_collection_panel : Lobby_OrbCollectionPanel = $VBoxContainer/HBoxContainer/OrbCollectionPanel

var _loadout : Loadout = null
var _orb_collection : OrbCollection = null
var _selected_body_slot : Enums.OrbSlot = Enums.OrbSlot.UNSET
var _selected_orb_type : TypeIds.Orb = TypeIds.Orb.UNSET


func _on_start_game_button_pressed() -> void:
	start_game_button_pressed.emit()


func _on_delete_save_button_pressed() -> void:
	delete_save_button_pressed.emit()


func set_data(loadout: Loadout, orb_collection: OrbCollection) -> void:
	_loadout = loadout if loadout != null else Loadout.new()
	_orb_collection = orb_collection if orb_collection != null else OrbCollection.new()
	
		
	_orb_collection_panel.set_data(_orb_collection.get_data())


func _on_body_panel_head_slot_button_pressed() -> void:
	if _selected_orb_type == Enums.OrbSlot.UNSET:
		_set_selected_body_slot(Enums.OrbSlot.HEAD)
	else:
		pass # Update orb slot and update texture


func _on_body_panel_chest_slot_button_pressed() -> void:
	if _selected_orb_type == Enums.OrbSlot.UNSET:
		_set_selected_body_slot(Enums.OrbSlot.CHEST)
	else:
		pass # Update orb slot and update texture


func _on_body_panel_hands_slot_button_pressed() -> void:
	if _selected_orb_type == Enums.OrbSlot.UNSET:
		_set_selected_body_slot(Enums.OrbSlot.HANDS)
	else:
		pass # Update orb slot and update texture


func _on_body_panel_legs_slot_button_pressed() -> void:
	if _selected_orb_type == Enums.OrbSlot.UNSET:
		_set_selected_body_slot(Enums.OrbSlot.LEGS)
	else:
		pass # Update orb slot and update texture


func _on_orb_collection_panel_button_pressed(orb_type_id: TypeIds.Orb) -> void:
	if _selected_body_slot == Enums.OrbSlot.UNSET:
		_set_selected_orb_type(orb_type_id)
	else:
		pass # Set orb slot and update texture


func _set_selected_body_slot(body_slot: Enums.OrbSlot) -> void:
	_selected_body_slot = body_slot
	print("Selected body slot: %s" % str(Enums.OrbSlot.keys()[body_slot]))


func _set_selected_orb_type(orb_type: TypeIds.Orb) -> void:
	_selected_orb_type = orb_type
	print("Selected orb type: %s" % str(TypeIds.Orb.keys()[orb_type]))

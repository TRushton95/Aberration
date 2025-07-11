extends PanelContainer
class_name Lobby

signal start_game_button_pressed(loadout: Loadout)
signal delete_save_button_pressed

@onready var _body_panel : Lobby_BodyPanel = $VBoxContainer/HBoxContainer/BodyPanel
@onready var _orb_collection_panel : Lobby_OrbCollectionPanel = $VBoxContainer/HBoxContainer/OrbCollectionPanel

var _loadout : Loadout = null
var _orb_collection : OrbCollection = null
var _selected_orb_type : TypeIds.Orb = TypeIds.Orb.UNSET


func _on_start_game_button_pressed() -> void:
	start_game_button_pressed.emit(_loadout)


func _on_delete_save_button_pressed() -> void:
	delete_save_button_pressed.emit()


func _on_body_panel_head_slot_button_pressed() -> void:
	_set_body_slot_orb(Enums.OrbSlot.HEAD, _selected_orb_type)
	_set_selected_orb_type(TypeIds.Orb.UNSET)


func _on_body_panel_chest_slot_button_pressed() -> void:
	_set_body_slot_orb(Enums.OrbSlot.CHEST, _selected_orb_type)
	_set_selected_orb_type(TypeIds.Orb.UNSET)


func _on_body_panel_hands_slot_button_pressed() -> void:
	_set_body_slot_orb(Enums.OrbSlot.HANDS, _selected_orb_type)
	_set_selected_orb_type(TypeIds.Orb.UNSET)


func _on_body_panel_legs_slot_button_pressed() -> void:
	_set_body_slot_orb(Enums.OrbSlot.LEGS, _selected_orb_type)
	_set_selected_orb_type(TypeIds.Orb.UNSET)


func _on_orb_collection_panel_button_pressed(orb_type_id: TypeIds.Orb) -> void:
	_set_selected_orb_type(orb_type_id)


func set_data(loadout: Loadout, orb_collection: OrbCollection) -> void:
	_loadout = loadout if loadout != null else Loadout.new()
	_orb_collection = orb_collection if orb_collection != null else OrbCollection.new()
	
	_orb_collection_panel.set_data(_orb_collection.get_data())


func _set_body_slot_orb(body_slot: Enums.OrbSlot, orb_type_id: TypeIds.Orb) -> void:
	var prev_orb_type : TypeIds.Orb = _get_loadout_slot(body_slot)
	if prev_orb_type != TypeIds.Orb.UNSET:
		_orb_collection.add_quantity(prev_orb_type, 1)
	else:
		_orb_collection.remove_quantity(orb_type_id, 1)
		
	_set_loadout_slot(body_slot, orb_type_id)
	var display_text : String = OrbDataFactory.get_orb_name(_selected_orb_type) if _selected_orb_type != TypeIds.Orb.UNSET else ""
	_set_loadout_slot_text(body_slot, display_text)
	
	set_data(_loadout, _orb_collection)


func _set_loadout_slot_text(body_slot: Enums.OrbSlot, text: String) -> void:
	match body_slot:
		Enums.OrbSlot.HEAD:
			_body_panel.set_head_slot_equip_text(text)
		Enums.OrbSlot.CHEST:
			_body_panel.set_chest_slot_equip_text(text)
		Enums.OrbSlot.HANDS:
			_body_panel.set_hands_slot_equip_text(text)
		Enums.OrbSlot.LEGS:
			_body_panel.set_legs_slot_equip_text(text)


func _get_loadout_slot(body_slot: Enums.OrbSlot) -> TypeIds.Orb:
	var result : TypeIds.Orb = TypeIds.Orb.UNSET
	
	match body_slot:
		Enums.OrbSlot.HEAD:
			result = _loadout.head_orb
		Enums.OrbSlot.CHEST:
			result = _loadout.chest_orb
		Enums.OrbSlot.HANDS:
			result = _loadout.hands_orb
		Enums.OrbSlot.LEGS:
			result = _loadout.legs_orb
			
	return result


func _set_loadout_slot(body_slot: Enums.OrbSlot, orb_type_id: TypeIds.Orb) -> void:
	match body_slot:
		Enums.OrbSlot.HEAD:
			_loadout.head_orb = orb_type_id
		Enums.OrbSlot.CHEST:
			_loadout.chest_orb = orb_type_id
		Enums.OrbSlot.HANDS:
			_loadout.hands_orb = orb_type_id
		Enums.OrbSlot.LEGS:
			_loadout.legs_orb = orb_type_id


func _set_selected_orb_type(orb_type: TypeIds.Orb) -> void:
	if _selected_orb_type == orb_type:
		return
		
	_selected_orb_type = orb_type
	print("Selected orb type: %s" % str(TypeIds.Orb.keys()[orb_type]))

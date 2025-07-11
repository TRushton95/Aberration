extends PanelContainer
class_name Lobby

signal start_game_button_pressed(loadout: Loadout)
signal delete_save_button_pressed

@onready var _body_panel : Lobby_BodyPanel = $VBoxContainer/HBoxContainer/BodyPanel
@onready var _orb_collection_panel : Lobby_OrbCollectionPanel = $VBoxContainer/HBoxContainer/OrbCollectionPanel

var _loadout : Loadout = null
var _orb_collection : OrbCollection = null
var _selected_body_slot : Enums.OrbSlot = Enums.OrbSlot.UNSET
var _selected_orb_type : TypeIds.Orb = TypeIds.Orb.UNSET


func _on_start_game_button_pressed() -> void:
	start_game_button_pressed.emit(_loadout)


func _on_delete_save_button_pressed() -> void:
	delete_save_button_pressed.emit()


func _on_body_panel_head_slot_button_pressed() -> void:
	if _selected_orb_type == TypeIds.Orb.UNSET:
		_set_selected_body_slot(Enums.OrbSlot.HEAD)
		_body_panel.set_head_slot_equip_text("")
	else:
		_loadout.head_orb = _selected_orb_type
		_body_panel.set_head_slot_equip_text(OrbDataFactory.get_orb_name(_selected_orb_type))
		_set_selected_orb_type(TypeIds.Orb.UNSET)


func _on_body_panel_chest_slot_button_pressed() -> void:
	if _selected_orb_type == TypeIds.Orb.UNSET:
		_loadout.chest_orb = TypeIds.Orb.UNSET
		_body_panel.set_chest_slot_equip_text("")
	else:
		_loadout.chest_orb = _selected_orb_type
		_body_panel.set_chest_slot_equip_text(OrbDataFactory.get_orb_name(_selected_orb_type))
		_set_selected_orb_type(TypeIds.Orb.UNSET)


func _on_body_panel_hands_slot_button_pressed() -> void:
	if _selected_orb_type == TypeIds.Orb.UNSET:
		_loadout.hands_orb = TypeIds.Orb.UNSET
		_body_panel.set_hands_slot_equip_text("")
	else:
		_loadout.hands_orb = _selected_orb_type
		_body_panel.set_hands_slot_equip_text(OrbDataFactory.get_orb_name(_selected_orb_type))
		_set_selected_orb_type(TypeIds.Orb.UNSET)


func _on_body_panel_legs_slot_button_pressed() -> void:
	if _selected_orb_type == TypeIds.Orb.UNSET:
		_loadout.legs_orb = TypeIds.Orb.UNSET
		_body_panel.set_legs_slot_equip_text("")
	else:
		_loadout.legs_orb = _selected_orb_type
		_body_panel.set_legs_slot_equip_text(OrbDataFactory.get_orb_name(_selected_orb_type))
		_set_selected_orb_type(TypeIds.Orb.UNSET)


func _on_orb_collection_panel_button_pressed(orb_type_id: TypeIds.Orb) -> void:
	if _selected_body_slot == Enums.OrbSlot.UNSET:
		_set_selected_orb_type(orb_type_id)
	else:
		match _selected_body_slot:
			Enums.OrbSlot.HEAD:
				_loadout.head_orb = orb_type_id
			Enums.OrbSlot.CHEST:
				_loadout.chest = orb_type_id
			Enums.OrbSlot.HANDS:
				_loadout.hands = orb_type_id
			Enums.OrbSlot.LEGS:
				_loadout.legs = orb_type_id
		_set_selected_body_slot(Enums.OrbSlot.UNSET)


func set_data(loadout: Loadout, orb_collection: OrbCollection) -> void:
	_loadout = loadout if loadout != null else Loadout.new()
	_orb_collection = orb_collection if orb_collection != null else OrbCollection.new()
	
	_orb_collection_panel.set_data(_orb_collection.get_data())


func _set_selected_body_slot(body_slot: Enums.OrbSlot) -> void:
	_selected_body_slot = body_slot
	print("Selected body slot: %s" % str(Enums.OrbSlot.keys()[body_slot]))


func _set_selected_orb_type(orb_type: TypeIds.Orb) -> void:
	_selected_orb_type = orb_type
	print("Selected orb type: %s" % str(TypeIds.Orb.keys()[orb_type]))

extends PanelContainer
class_name Lobby

var _selected_body_slot : Enums.OrbSlot = Enums.OrbSlot.UNSET
var _selected_orb_type : TypeIds.Orb = TypeIds.Orb.UNSET


func _on_body_panel_head_slot_button_pressed() -> void:
	if _selected_orb_type == Enums.OrbSlot.UNSET:
		_set_selected_body_slot(Enums.OrbSlot.HEAD)


func _on_body_panel_chest_slot_button_pressed() -> void:
	if _selected_orb_type == Enums.OrbSlot.UNSET:
		_set_selected_body_slot(Enums.OrbSlot.CHEST)


func _on_body_panel_hands_slot_button_pressed() -> void:
	if _selected_orb_type == Enums.OrbSlot.UNSET:
		_set_selected_body_slot(Enums.OrbSlot.HANDS)


func _on_body_panel_legs_slot_button_pressed() -> void:
	if _selected_orb_type == Enums.OrbSlot.UNSET:
		_set_selected_body_slot(Enums.OrbSlot.LEGS)


func _set_selected_body_slot(body_slot: Enums.OrbSlot) -> void:
	_selected_body_slot = body_slot


func _set_selected_orb_type(orb_type: TypeIds.Orb) -> void:
	_selected_orb_type = orb_type

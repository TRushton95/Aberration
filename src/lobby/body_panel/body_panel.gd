extends PanelContainer
class_name Lobby_BodyPanel

signal head_slot_button_pressed
signal chest_slot_button_pressed
signal hands_slot_button_pressed
signal legs_slot_button_pressed

@onready var _head_slot_button : Button = $VBoxContainer/HeadSlotButton
@onready var _chest_slot_button : Button = $VBoxContainer/ChestSlotButton
@onready var _hands_slot_button : Button = $VBoxContainer/HandsSlotButton
@onready var _legs_slot_button : Button = $VBoxContainer/LegsSlotButton


func _on_head_slot_button_pressed() -> void:
	head_slot_button_pressed.emit()


func _on_chest_slot_button_pressed() -> void:
	chest_slot_button_pressed.emit()


func _on_hands_slot_button_pressed() -> void:
	hands_slot_button_pressed.emit()


func _on_legs_slot_button_pressed() -> void:
	legs_slot_button_pressed.emit()


func set_head_slot_equip_text(text: String) -> void:
	_head_slot_button.text = "Head" if text == "" else "Head (%s)" % text


func set_chest_slot_equip_text(text: String) -> void:
	_chest_slot_button.text = "Chest" if text == "" else "Chest (%s)" % text


func set_hands_slot_equip_text(text: String) -> void:
	_hands_slot_button.text = "Hands" if text == "" else "Hands (%s)" % text


func set_legs_slot_equip_text(text: String) -> void:
	_legs_slot_button.text = "Legs" if text == "" else "Legs (%s)" % text


func set_head_slot_icon(texture: Texture) -> void:
	_head_slot_button.texture_normal = texture


func set_chest_slot_icon(texture: Texture) -> void:
	_chest_slot_button.texture_normal = texture


func set_hands_slot_icon(texture: Texture) -> void:
	_hands_slot_button.texture_normal = texture


func set_legs_slot_icon(texture: Texture) -> void:
	_legs_slot_button.texture_normal = texture

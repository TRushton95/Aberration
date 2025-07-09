extends VBoxContainer
class_name Lobby_BodyPanel

signal head_slot_button_pressed
signal chest_slot_button_pressed
signal hands_slot_button_pressed
signal legs_slot_button_pressed

@onready var _head_slot_button : TextureButton = $VBoxContainer/HeadSlotButton
@onready var _chest_slot_button : TextureButton = $VBoxContainer/ChestSlotButton
@onready var _hands_slot_button : TextureButton = $VBoxContainer/HandsSlotButton
@onready var _legs_slot_button : TextureButton = $VBoxContainer/LegsSlotButton


func _on_head_slot_button_pressed() -> void:
	head_slot_button_pressed.emit()


func _on_chest_slot_button_pressed() -> void:
	chest_slot_button_pressed.emit()


func _on_hands_slot_button_pressed() -> void:
	hands_slot_button_pressed.emit()


func _on_legs_slot_button_pressed() -> void:
	legs_slot_button_pressed.emit()


func set_head_slot_icon(texture: Texture) -> void:
	_head_slot_button.texture_normal = texture


func set_chest_slot_icon(texture: Texture) -> void:
	_chest_slot_button.texture_normal = texture


func set_hands_slot_icon(texture: Texture) -> void:
	_hands_slot_button.texture_normal = texture


func set_legs_slot_icon(texture: Texture) -> void:
	_legs_slot_button.texture_normal = texture

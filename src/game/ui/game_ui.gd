extends CanvasLayer
class_name GameUI

const ORB_LABEL_FORMAT : String = "%s: %s"

@onready var _level_label : Label = $MarginContainer/VBoxContainer2/LevelLabel
@onready var _head_orb_label : Label = $MarginContainer/VBoxContainer2/VBoxContainer/HeadOrbLabel
@onready var _chest_orb_label : Label = $MarginContainer/VBoxContainer2/VBoxContainer/ChestOrbLabel
@onready var _hands_orb_label : Label = $MarginContainer/VBoxContainer2/VBoxContainer/HandsOrbLabel
@onready var _legs_orb_label : Label = $MarginContainer/VBoxContainer2/VBoxContainer/LegsOrbLabel
@onready var _orb_container_panel : GameUI_OrbContainerPanel = $OrbContainerPanel


func set_orb_names(head: String, chest: String, hands: String, legs: String) -> void:
	_head_orb_label.text = ORB_LABEL_FORMAT % [ "Head", head ]
	_chest_orb_label.text = ORB_LABEL_FORMAT % [ "Chest", chest ]
	_hands_orb_label.text = ORB_LABEL_FORMAT % [ "Hands", hands ]
	_legs_orb_label.text = ORB_LABEL_FORMAT % [ "Legs", legs ]


func set_orb_container_data(orb_data: Dictionary[TypeIds.Orb, int]) -> void:
	_orb_container_panel.set_data(orb_data)


func set_level(level: int) -> void:
	_level_label.text = "Level: %s" % str(level)

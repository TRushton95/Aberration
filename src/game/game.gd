extends Node2D
class_name Game

@onready var _player : Player = $Player


func _ready() -> void:
	var fire_orb : Orb = load("res://game/orbs/fire/fire_orb.tscn").instantiate()
	_player.set_chest_orb(fire_orb)

extends Node2D
class_name OrbPickup

@export var _reward_orb_scene : PackedScene


func get_reward() -> Orb:
	var reward : Orb = null
	
	if _reward_orb_scene != null:
		reward = _reward_orb_scene.instantiate() as Orb # TODO: Change this to use OrbTypeIds
	
	return reward

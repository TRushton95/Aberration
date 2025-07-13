extends Resource
class_name Ability

@export var _target : Target
@export var _cast_time : float = 0.0
@export var _cooldown : float = 0.0
@export var _effects : Array[Effect] = []


func execute(player: Player, target: Variant) -> void:
	if !_target.validate(target):
		return
		
	for i in _effects.size():
		var effect : Effect = _effects[i]
		if effect == null:
			continue
			
		effect.execute(player, target)

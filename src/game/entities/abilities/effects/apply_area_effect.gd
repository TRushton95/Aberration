extends Effect
class_name AreaEffect

@export var _shape : Shape2D
@export var _effects : Array[Effect] = []


func _internal_execute(player: Player, target: Variant) -> void:
	if target is not Vector2:
		return
		
	if _shape == null:
		return
		
	var intersecting_bodies : Array[Node2D] = SpatialHelper.get_intersecting_bodies(player.get_world_2d().direct_space_state, target, _shape, Constants.CollisionLayers.ENEMY)
	
	for i in intersecting_bodies.size():
		var enemy : Enemy = intersecting_bodies[i] as Enemy
		if enemy == null:
			continue
			
		for j in _effects.size():
			var effect : Effect = _effects[j]
			if effect == null:
				continue
				
			effect.execute(player, enemy)

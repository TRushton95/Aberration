extends Node


static func get_intersecting_bodies(direct_space_state: PhysicsDirectSpaceState2D, global_pos: Vector2, radius: float) -> Array[Node2D]:
	var result : Array[Node2D] = []
	
	if direct_space_state == null:
		return result
		
	var circle_shape : CircleShape2D = CircleShape2D.new()
	circle_shape.radius = radius
	
	var query : PhysicsShapeQueryParameters2D = PhysicsShapeQueryParameters2D.new()
	query.shape = circle_shape
	query.transform = query.transform.translated(global_pos)
	
	var query_result : Array[Dictionary] = direct_space_state.intersect_shape(query, 32)
	
	for i in query_result.size():
		var collider : Node2D = query_result[i]["collider"]
		if collider == null:
			continue
			
		result.push_back(collider)
	
	return result

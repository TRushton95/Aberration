extends Node


static func get_intersecting_bodies_circle(direct_space_state: PhysicsDirectSpaceState2D, global_pos: Vector2, radius: int) -> Array[Node2D]:
	var shape : CircleShape2D = CircleShape2D.new()
	shape.radius = radius
	
	return get_intersecting_bodies(direct_space_state, global_pos, shape)


static func get_intersecting_bodies(direct_space_state: PhysicsDirectSpaceState2D, global_pos: Vector2, shape: Shape2D, collision_mask: int = -1) -> Array[Node2D]:
	var result : Array[Node2D] = []
	
	if direct_space_state == null:
		return result
	
	var query : PhysicsShapeQueryParameters2D = PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = query.transform.translated(global_pos)
	
	if collision_mask > 0:
		query.collision_mask = collision_mask
	
	var query_result : Array[Dictionary] = direct_space_state.intersect_shape(query, 32)
	
	for i in query_result.size():
		var collider : Node2D = query_result[i]["collider"]
		if collider == null:
			continue
			
		result.push_back(collider)
	
	return result

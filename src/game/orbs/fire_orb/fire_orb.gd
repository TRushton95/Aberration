extends Orb

@onready var _chest_burning_timer : Timer = $ChestBurningTimer


func _on_chest_burning_timer_timeout(player: Player) -> void:
	var colliders : Array[Node2D] = SpatialHelper.get_intersecting_bodies_circle(player.get_world_2d().direct_space_state, player.global_position, 100)
	
	for i in colliders.size():
		var collider : Node2D = colliders[i] as Node2D
		if collider == null || !collider is Enemy:
			continue
			
		collider = collider as Enemy
		collider.get_health_vital().remove(5)


func _on_chest_entered(player: Player) -> void:
	_chest_burning_timer.timeout.connect(_on_chest_burning_timer_timeout.bind(player))
	_chest_burning_timer.start()


func _on_chest_exited(player: Player) -> void:
	_chest_burning_timer.timeout.disconnect(_on_chest_burning_timer_timeout.bind(player))
	_chest_burning_timer.stop()

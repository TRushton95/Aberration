extends Node
class_name DirectionComponent

signal direction_changed(direction: Enums.Direction)

@export var _parent : CharacterBody2D

var _direction : Enums.Direction = Enums.Direction.UP
var _animation_suffix_lookup : Dictionary = {
	Enums.Direction.UP: "_up",
	Enums.Direction.DOWN: "_down",
	Enums.Direction.LEFT: "_left",
	Enums.Direction.RIGHT: "_right"
}


func _process(_delta: float) -> void:
	if _parent == null || _parent.velocity == Vector2.ZERO:
		return
		
	var direction = Enums.Direction.DOWN
	var angle_deg = snapped(rad_to_deg(_parent.velocity.angle()), 1)
	
	if angle_deg > 45 && angle_deg < 135:
		direction = Enums.Direction.DOWN
	elif angle_deg >= 135 || angle_deg <= -135:
		direction = Enums.Direction.LEFT
	elif angle_deg > -135 && angle_deg < -45:
		direction = Enums.Direction.UP
	else:
		direction = Enums.Direction.RIGHT
		
	_set_direction(direction)


func get_animation_suffix() -> String:
	var result : String = ""
	
	if _animation_suffix_lookup.has(_direction):
		result = _animation_suffix_lookup[_direction]
		
	return result


func get_direction() -> Enums.Direction:
	return _direction


func get_angle() -> Vector2:
	var result : Vector2 = Vector2.DOWN
	
	match _direction:
		Enums.Direction.UP:
			result = Vector2.UP
		Enums.Direction.DOWN:
			result = Vector2.DOWN
		Enums.Direction.LEFT:
			result = Vector2.LEFT
		Enums.Direction.RIGHT:
			result = Vector2.RIGHT
			
	return result


func _set_direction(direction: Enums.Direction) -> void:
	if _direction == direction:
		return
		
	_direction = direction
	direction_changed.emit(_direction)

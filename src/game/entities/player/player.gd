extends Entity
class_name Player

@export var _direction_component : DirectionComponent

@onready var _weapon : Weapon = $Sword


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		_weapon.fire()


func _physics_process(delta: float) -> void:
	var x_movement : float = Input.get_axis("move_left", "move_right")
	var y_movement : float = Input.get_axis("move_up", "move_down")
	
	velocity = Vector2(x_movement, y_movement).normalized() * _move_speed
	move_and_slide()


func get_direction_component() -> DirectionComponent:
	return _direction_component


func _on_direction_component_direction_changed(direction: Enums.Direction) -> void:
	pass # Replace with function body.

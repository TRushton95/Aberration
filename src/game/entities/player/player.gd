extends Entity
class_name Player

@export var _direction_component : DirectionComponent

@onready var _weapon : Weapon = $Sword

var _chest_orb : Orb


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		_weapon.fire()
		
	if _chest_orb != null:
		_chest_orb.update_chest(self)


func _physics_process(delta: float) -> void:
	var x_movement : float = Input.get_axis("move_left", "move_right")
	var y_movement : float = Input.get_axis("move_up", "move_down")
	
	velocity = Vector2(x_movement, y_movement).normalized() * _move_speed
	move_and_slide()


func get_direction_component() -> DirectionComponent:
	return _direction_component


func _on_direction_component_direction_changed(direction: Enums.Direction) -> void:
	pass # Replace with function body.


func set_chest_orb(orb: Orb) -> void:
	if _chest_orb != null:
		_chest_orb.exit_chest(self)
		_chest_orb.queue_free()
		
	_chest_orb = orb
	add_child(_chest_orb)
	
	if _chest_orb != null:
		_chest_orb.enter_chest(self)

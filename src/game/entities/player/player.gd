extends CharacterBody2D

const SPEED : int = 500

@onready var _weapon : Weapon = $Sword


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		_weapon.fire()


func _physics_process(delta: float) -> void:
	var x_movement : float = Input.get_axis("move_left", "move_right")
	var y_movement : float = Input.get_axis("move_up", "move_down")
	
	velocity = Vector2(x_movement, y_movement).normalized() * SPEED
	move_and_slide()

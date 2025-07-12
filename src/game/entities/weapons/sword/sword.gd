extends Weapon

const ATTACK_DURATION_S : float = 0.25

@export var _attack_circle_radius : int = 100
@export var _damage : float = 50.0
@export var _sweep_angle_rads : float = TAU / 4

@onready var _hurtbox : Area2D = $Hurtbox

var _attack_progress_s : float = -1.0
var _attack_direction : Vector2
	

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if !body is Enemy:
		return
		
	body = body as Enemy
	body.get_health_vital().remove(_damage)


func _on_fired() -> void:
	_attack_progress_s = 0.0
	_attack_direction = _owner.global_position.direction_to(get_global_mouse_position())
	
	var percentage_progress : float = _attack_progress_s / ATTACK_DURATION_S
	_update_position(percentage_progress)
	_hurtbox.monitoring = true


func _on_ready() -> void:
	_update_position(0.0)


func _physics_process(delta: float) -> void:
	if _attack_progress_s < 0.0:
		var center_offset : Vector2 = Vector2(0, -64) # Horrible hardcoding
		var mouse_pos : Vector2 = get_global_mouse_position()
		var mouse_angle : Vector2 = _owner.global_position.direction_to(mouse_pos)
		
		global_position = _owner.global_position + center_offset + (mouse_angle * _attack_circle_radius)
		rotation = mouse_angle.angle() + (TAU / 4)
		return
		
	_attack_progress_s += delta
	
	var percentage_progress : float = _attack_progress_s / ATTACK_DURATION_S
	_update_position(percentage_progress)
	
	if _attack_progress_s > ATTACK_DURATION_S:
		_attack_progress_s = -1.0
		_hurtbox.monitoring = false


func _update_position(percentage_progress: float) -> void:
	var angle_rads : float = _attack_direction.angle() - (_sweep_angle_rads / 2) + (_sweep_angle_rads * percentage_progress)
	var direction_from_owner : Vector2 = Vector2.from_angle(angle_rads)
	
	var center_offset : Vector2 = Vector2(0, -64) # Horrible hardcoding
	global_position = _owner.global_position + center_offset + (direction_from_owner * _attack_circle_radius)
	rotation = angle_rads + (TAU / 4)

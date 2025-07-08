extends Weapon

const ATTACK_DURATION_S : float = 0.5
const ATTACK_DISTANCE : int = 100

@export var _damage : float = 50.0

@onready var _hurtbox : Area2D = $Hurtbox

var _attack_progress_s : float = -1.0


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if !body is Enemy:
		return
		
	body = body as Enemy
	body.get_health_vital().remove(_damage)


func _on_fired() -> void:
	_attack_progress_s = 0.0
	
	var percentage_progress : float = _attack_progress_s / ATTACK_DURATION_S
	_update_position(percentage_progress)
	_hurtbox.monitoring = true


func _physics_process(delta: float) -> void:
	if _attack_progress_s < 0.0:
		return
		
	_attack_progress_s += delta
	
	var percentage_progress : float = _attack_progress_s / ATTACK_DURATION_S
	_update_position(percentage_progress)
	
	if _attack_progress_s > ATTACK_DURATION_S:
		_attack_progress_s = -1.0
		_update_position(0)
		_hurtbox.monitoring = false


func _update_position(percentage_progress: float) -> void:
	var angle_rads: float = TAU * percentage_progress
	var direction_from_owner : Vector2 = Vector2.from_angle(angle_rads)
	global_position = _owner.global_position + (direction_from_owner * ATTACK_DISTANCE)
	rotation = angle_rads + (TAU / 4)

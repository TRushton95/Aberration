extends Node2D
class_name Projectile

signal hit

@export var _speed : int = 500
@export var _hurtbox : Area2D

var destination : Vector2


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		hit.emit()
		queue_free()


func _ready() -> void:
	if _hurtbox != null:
		_hurtbox.body_entered.connect(_on_hurtbox_body_entered)


func setup(source_pos: Vector2, dest_pos: Vector2) -> void:
	position = source_pos
	destination = dest_pos


func _process(delta: float) -> void:
	var remaining_distance : float = position.distance_to(destination)
	if remaining_distance < _speed * delta:
		hit.emit()
		queue_free()
		return
		
	position += position.direction_to(destination) * _speed * delta
	

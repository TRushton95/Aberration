extends Entity
class_name Player

signal picked_up_orb(type_id: TypeIds.Orb)

@export var _direction_component : DirectionComponent

@onready var _weapon : Weapon = $Sword

var _orb_slots : Dictionary[Enums.OrbSlot, Orb] = {
	Enums.OrbSlot.LEGS: null,
	Enums.OrbSlot.CHEST: null,
	Enums.OrbSlot.HEAD: null,
	Enums.OrbSlot.HANDS: null
}


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body == null:
		return
		
	if body is OrbPickup:
		body = body as OrbPickup
		var reward : Orb = body.get_reward()
		set_orb_slot(Enums.OrbSlot.CHEST, reward)
		body.queue_free()
		picked_up_orb.emit(reward.get_type_id())


func _process(delta: float) -> void:
	_update_orb_slots()
	
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


func set_orb_slot(slot: Enums.OrbSlot, new_orb: Orb) -> void:
	if !_orb_slots.has(slot):
		return
		
	var prev_orb : Orb = _orb_slots[slot]
	
	if prev_orb != null:
		prev_orb.exit_chest(self)
		prev_orb.queue_free()
		
	_orb_slots[slot] = new_orb
	
	if new_orb != null:
		add_child(new_orb)
		new_orb.enter_chest(self)


func get_orb_slot(slot: Enums.OrbSlot) -> Orb:
	var result : Orb = null
	
	if _orb_slots.has(slot):
		result = _orb_slots[slot]
		
	return result


func _update_orb_slots() -> void:
	for slot in _orb_slots.keys():
		var orb : Orb = _orb_slots[slot] as Orb
		if orb == null:
			continue
			
		match slot:
			Enums.OrbSlot.LEGS:
				orb.update_legs(self)
			Enums.OrbSlot.CHEST:
				orb.update_chest(self)
			Enums.OrbSlot.HANDS:
				orb.update_hands(self)
			Enums.OrbSlot.HEAD:
				orb.update_head(self)

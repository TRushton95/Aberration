extends Entity
class_name Player

signal picked_up_orb(type_id: TypeIds.Orb)
signal died

@export var _direction_component : DirectionComponent

@onready var _anim_player : AnimationPlayer = $AnimationPlayer
@onready var _sprite : Sprite2D = $Sprite2D
@onready var _orb_container : Node = $OrbContainer
@onready var _weapon : Weapon = $Sword

var _orb_slots : Dictionary[Enums.OrbSlot, Orb] = {
	Enums.OrbSlot.LEGS: null,
	Enums.OrbSlot.CHEST: null,
	Enums.OrbSlot.HEAD: null,
	Enums.OrbSlot.HANDS: null
}

var _prev_direction : Enums.Direction = Enums.Direction.DOWN


func _on_health_vital_empty() -> void:
	died.emit()


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body == null:
		return
		
	if body is OrbPickup:
		body = body as OrbPickup
		var orb_type_id : TypeIds.Orb = body.get_orb_type_id()
		picked_up_orb.emit(orb_type_id)
		body.queue_free()


func _process(delta: float) -> void:
	_update_orb()
	
	if Input.is_action_just_pressed("attack"):
		_weapon.fire()


func _physics_process(delta: float) -> void:
	var x_movement : float = Input.get_axis("move_left", "move_right")
	var y_movement : float = Input.get_axis("move_up", "move_down")
	
	velocity = Vector2(x_movement, y_movement).normalized() * _move_speed
	move_and_slide()
	
	if velocity != Vector2.ZERO:
		_anim_player.play("walking")
	else:
		_anim_player.play("RESET")


func set_loadout(loadout: Loadout) -> void:
	var head_orb : Orb = OrbFactory.build(loadout.head_orb)
	var chest_orb : Orb = OrbFactory.build(loadout.chest_orb)
	var hands_orb : Orb = OrbFactory.build(loadout.hands_orb)
	var legs_orb : Orb = OrbFactory.build(loadout.legs_orb)
	
	set_orb_slot(Enums.OrbSlot.HEAD, head_orb)
	set_orb_slot(Enums.OrbSlot.CHEST, chest_orb)
	set_orb_slot(Enums.OrbSlot.HANDS, hands_orb)
	set_orb_slot(Enums.OrbSlot.LEGS, legs_orb)


func get_direction_component() -> DirectionComponent:
	return _direction_component


func _on_direction_component_direction_changed(direction: Enums.Direction) -> void:
	if direction == Enums.Direction.LEFT:
		_sprite.flip_h = true
	elif direction == Enums.Direction.RIGHT:
		_sprite.flip_h = false


func set_orb_slot(slot: Enums.OrbSlot, new_orb: Orb) -> void:
	if !_orb_slots.has(slot):
		return
		
	var prev_orb : Orb = _orb_slots[slot]
	
	if prev_orb != null:
		prev_orb.exit_chest(self)
		prev_orb.queue_free()
		
	_orb_slots[slot] = new_orb
	
	if new_orb != null:
		_orb_container.add_child(new_orb)
		new_orb.enter_chest(self)


func get_orb_slot(slot: Enums.OrbSlot) -> Orb:
	var result : Orb = null
	
	if _orb_slots.has(slot):
		result = _orb_slots[slot]
		
	return result


func _update_orb() -> void:
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

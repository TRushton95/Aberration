extends PanelContainer
class_name Lobby_OrbCollectionPanel

signal button_pressed(orb_type_id: TypeIds.Orb)

@onready var _container : GridContainer = $GridContainer


func _on_button_connect(orb_type_id: TypeIds.Orb) -> void:
	button_pressed.emit(orb_type_id)


func set_data(orb_collection_data: Dictionary[TypeIds.Orb, int]) -> void:
	_clear()
	
	for orb_type_id in orb_collection_data.keys():
		var orb_data : OrbTypeData = OrbDataFactory.get_orb_data(orb_type_id)
		if orb_data == null:
			continue
			
		var quantity : int = orb_collection_data[orb_type_id]
		
		var button : Button = Button.new()
		button.pressed.connect(_on_button_connect.bind(orb_type_id))
		button.text = "%s (%s)" % [ orb_data.get_display_name(), str(quantity) ]
		_container.add_child(button)


func _clear() -> void:
	var children : Array[Node] = _container.get_children()
	
	for i in children.size():
		var child : Node = children[i]
		if child == null:
			continue
			
		child.queue_free()

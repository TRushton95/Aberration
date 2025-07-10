extends PanelContainer
class_name GameUI_OrbContainerPanel

@onready var _container : VBoxContainer = $VBoxContainer


func set_data(orb_collection_data: Dictionary[TypeIds.Orb, int]) -> void:
	_clear()
	
	for orb_type_id in orb_collection_data.keys():
		var orb_type_data : OrbTypeData = OrbDataFactory.get_orb_data(orb_type_id)
		if orb_type_data == null:
			continue
			
		var label : Label = Label.new()
		label.text = "%s: %s" % [ orb_type_data.get_display_name(), orb_collection_data[orb_type_id] ]
		
		_container.add_child(label)


func _clear() -> void:
	var children : Array[Node] = _container.get_children()
	
	for i in children.size():
		var child : Node = children[i]
		if child == null:
			continue
			
		child.queue_free()

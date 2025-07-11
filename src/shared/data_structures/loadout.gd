extends Resource
class_name Loadout

@export var head_orb : TypeIds.Orb
@export var chest_orb : TypeIds.Orb
@export var hands_orb : TypeIds.Orb
@export var legs_orb : TypeIds.Orb


#func get_head_orb() -> TypeIds.Orb:
	#return _head_orb
#
#
#func get_chest_orb() -> TypeIds.Orb:
	#return _chest_orb
#
#
#func get_hands_orb() -> TypeIds.Orb:
	#return _hands_orb
#
#
#func get_legs_orb() -> TypeIds.Orb:
	#return _legs_orb


func get_display_string() -> String:
	var head_data : OrbTypeData = OrbDataFactory.get_orb_data(head_orb)
	var chest_data : OrbTypeData = OrbDataFactory.get_orb_data(chest_orb)
	var legs_data : OrbTypeData = OrbDataFactory.get_orb_data(legs_orb)
	var hands_data : OrbTypeData = OrbDataFactory.get_orb_data(hands_orb)
	
	var head_name : String = head_data.get_display_name() if head_data != null else "None"
	var chest_name : String = chest_data.get_display_name() if chest_data != null else "None"
	var hands_name : String = legs_data.get_display_name() if legs_data != null else "None"
	var legs_name : String = hands_data.get_display_name() if hands_data != null else "None"
	
	return "head: %s\nchest: %s\nhands: %s\nlegs: %s" % [ head_name, chest_name, hands_name, legs_name ]

extends Node
class_name HealthVital

signal value_changed(value: float)
signal max_value_changed(value: float)
signal empty
signal full
signal hurt

@export var _max_value : float = 100.0

var _value : float


func _ready() -> void:
	_value = _max_value


func set_max_value(max_value: float) -> void:
	_max_value = max_value
	
	if max_value < _value:
		set_value(max_value)


func set_value(new_value: float) -> void:
	var clamped_value : float = clampf(new_value, 0.0, _max_value)
	
	if is_equal_approx(clamped_value, _value):
		return
		
	_value = clamped_value
	value_changed.emit(_value)
	
	if is_equal_approx(_value, _max_value):
		full.emit()
	elif is_equal_approx(_value, 0.0):
		empty.emit()


func add(value: int) -> void:
	set_value(_value + value)


func remove(value: float) -> void:
	set_value(_value - value)
	hurt.emit()


func get_value() -> float:
	return _value


func get_max_value() -> float:
	return _max_value


func get_display_string() -> String:
	return "%s / %s" % [ str(_value), str(_max_value) ]

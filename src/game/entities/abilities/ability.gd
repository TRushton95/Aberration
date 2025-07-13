extends Resource
class_name Ability

@export var _target : Target
@export var _cast_time : float = 0.0
@export var _cooldown : float = 0.0
@export var _effects : Array[Effect] = []
@export var _projectile_scene : PackedScene


func _on_projectile_hit(player: Player, target: Vector2) -> void:
	_execute_effects(player, target)


func execute(player: Player, target: Variant) -> void:
	if !_target.validate(target):
		return
		
	if _target.get_target_type() == Enums.TargetType.GROUND && _projectile_scene != null:
		_create_projectile(player, target)
	else:
		_execute_effects(player, target)



func _execute_effects(player: Player, target: Variant) -> void:
	for i in _effects.size():
		var effect : Effect = _effects[i]
		if effect == null:
			continue
			
		effect.execute(player, target)


func _create_projectile(player: Player, target: Vector2) -> void:
	if _projectile_scene == null:
		return
		
	var projectile : Projectile = _projectile_scene.instantiate() as Projectile
	if projectile == null:
		return
		
	player.get_tree().get_root().get_node("App/Game").add_child(projectile)
	projectile.setup(player.position, target)
	projectile.hit.connect(_on_projectile_hit.bind(player, target))

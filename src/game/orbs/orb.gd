extends Node
class_name Orb

signal chest_entered(player: Player)
signal chest_exited(player: Player)
signal chest_updated(player: Player)
signal legs_entered(player: Player)
signal legs_exited(player: Player)
signal legs_updated(player: Player)


func enter_chest(player: Player) -> void:
	chest_entered.emit(player)


func exit_chest(player: Player) -> void:
	chest_exited.emit(player)


func update_chest(player: Player) -> void:
	chest_updated.emit(player)


func enter_legs(player: Player) -> void:
	legs_entered.emit(player)


func exit_legs(player: Player) -> void:
	legs_exited.emit(player)


func update_legs(player: Player) -> void:
	legs_updated.emit(player)

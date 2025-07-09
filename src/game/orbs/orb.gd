extends Node
class_name Orb

signal chest_entered(player: Player)
signal chest_exited(player: Player)
signal chest_updated(player: Player)
signal legs_entered(player: Player)
signal legs_exited(player: Player)
signal legs_updated(player: Player)
signal hands_entered(player: Player)
signal hands_exited(player: Player)
signal hands_updated(player: Player)
signal head_entered(player: Player)
signal head_exited(player: Player)
signal head_updated(player: Player)


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


func enter_hands(player: Player) -> void:
	hands_entered.emit(player)


func exit_hands(player: Player) -> void:
	hands_exited.emit(player)


func update_hands(player: Player) -> void:
	hands_updated.emit(player)


func enter_head(player: Player) -> void:
	head_entered.emit(player)


func exit_head(player: Player) -> void:
	head_exited.emit(player)


func update_head(player: Player) -> void:
	head_updated.emit(player)

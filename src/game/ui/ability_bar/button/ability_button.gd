extends PanelContainer
class_name GameUI_AbilityButton

@onready var _button : TextureButton = $TextureButton
@onready var _progress_bar : TextureProgressBar = $TextureButton/TextureProgressBar


func set_texture(texture: Texture) -> void:
	_button.texture_normal = texture


func set_enabled(enabled: bool) -> void:
	_button.disabled = !enabled


func set_remaining_cooldown_percent(remaining_cooldown_percent: float) -> void:
	_progress_bar.value = remaining_cooldown_percent

"""
Script : NAME

"""

extends CustomPopup

# Signals

# Export variable

# Public variables

# Onready variables
onready var texture_rect: TextureRect = $Panel/MarginContainer/VBoxContainer/MarginContainer2/ColorRect/MarginContainer/TextureRect

# Setter Getter Functions

# Callback functions

# Self functions
func set_image(texture : Texture) -> void:
	texture_rect.set_texture(texture)
	set_texture_stretch_mode()
	

func set_texture_stretch_mode() -> void:
	var tx_size: Vector2 = texture_rect.get_texture().get_size()
	var tx_rect: Vector2 = texture_rect.get_size()
	
	if tx_size.x >= tx_rect.x or tx_size.y >= tx_rect.y:
		texture_rect.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT_CENTERED)
	else:
		texture_rect.set_stretch_mode(TextureRect.STRETCH_KEEP_CENTERED)


func custom_popup_centered() -> void:
	popup_centered_ratio(1.0)


# Signal functions
func _on_Viewport_size_changed() -> void:
	custom_popup_centered()
	set_texture_stretch_mode()
	

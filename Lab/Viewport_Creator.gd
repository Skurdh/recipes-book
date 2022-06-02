"""
Script : NAME

"""

extends Control

# Signals

# Export variable

# Public variables

# Onready variables


# Setter Getter Functions

# Callback functions
func _ready() -> void:
	yield(VisualServer, "frame_post_draw")
	var img = $ViewportContainer/Viewport.get_texture().get_data()
	img.flip_y()
	var e = img.compress(Image.COMPRESS_S3TC, Image.COMPRESS_SOURCE_GENERIC, 2000)
	img.save_png("user://L8.png")
	
	

# Self functions

# Signal functions

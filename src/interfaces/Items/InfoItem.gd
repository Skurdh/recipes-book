"""
Script : NAME

"""
extends HBoxContainer

# Signals

# Export variable
export(String, "cube", "calendar", "cook_time", "diet", "hat_chef", "portions", "preparation_time", "qualities") var icon: String = "cube"
export(bool) var create_atlas: bool
export(int) var icon_size: int = 28

# Public variables

# Onready variables

# Setter Getter Functions

# Callback functions
func _ready() -> void:
	if create_atlas:
		var new_atlas: AtlasTexture = AtlasTexture.new()
		new_atlas.set_atlas(load("res://assets/textures/icons/" + icon + ".png"))
		new_atlas.set_region(Rect2(0, 0, 32, 32))
		$TextureRect.set_texture(new_atlas)
	else:
		$TextureRect.set_texture(load("res://assets/textures/icons/" + icon + ".png"))
	
	$TextureRect.rect_min_size.x = icon_size


# Self functions
func populate(data: Dictionary) -> void:
	$Label.set_text(data.name)
	if create_atlas:
		$TextureRect.get_texture().set_region(Rect2(data.idx * 32, 0, 32, 32))

# Signal functions

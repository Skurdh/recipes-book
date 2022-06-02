"""
Script : NAME

"""
extends Button

# Signals

# Export variable

# Public variables

# Onready variables


# Setter Getter Functions

# Callback functions

# Self functions
func populate(recipe_data: Dictionary) -> void:
	$VBoxContainer/Titre.set_text(recipe_data.title + " de " + recipe_data.author)
	$VBoxContainer/Infos.set_text("creation data : " + String(recipe_data.create_time))

# Signal functions

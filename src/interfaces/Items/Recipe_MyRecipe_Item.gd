"""
Script : NAME

"""
extends HBoxContainer

# Signals

# Export variable

# Public variables

# Onready variables

# Setter Getter Functions

# Callback functions

# Self functions
func populate(id: int, recipe_data: Dictionary) -> void:
	$View/HBoxContainer/ID.set_text(String(id))
	$View/HBoxContainer/Title.set_text(recipe_data.title)
	$View/HBoxContainer/Date.set_text(recipe_data.create_time)


func get_view_button() -> Button:
	var button: Button = $View
	return button	

func get_modify_button() -> Button:
	var button: Button = $Modify
	return button


func get_delete_button() -> Button:
	var button: Button = $Delete
	return button


# Signal functions

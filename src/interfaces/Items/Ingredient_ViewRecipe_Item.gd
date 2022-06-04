"""
Script : NAME

"""

extends MarginContainer

# Signals

# Export variable

# Public variables

# Onready variables
var ingredient_data: Dictionary = {}

# Setter Getter Functions

# Callback functions

# Self functions
func populate(data: Dictionary) -> void:
	if not data.has("ingredient"):
		queue_free()
	
	ingredient_data = data.duplicate()
	$HBoxContainer/Ingredient.bbcode_text += data.ingredient
	if data.has("quantity"):
		$HBoxContainer/Quantity.set_text(String(data.quantity) + " " + data.unit if data.has("unit") else "")
	if data.has("add"):
		$HBoxContainer/Ingredient.bbcode_text += "  [i]" + data.add + "[/i]"


# Signal functions

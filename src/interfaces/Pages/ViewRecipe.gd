"""
Script : NAME

"""

extends CustomPopup

# Signals

# Export variable

# Public variables

# Onready variables


# Setter Getter Functions

# Callback functions

# Self functions
func init(data: Dictionary) -> void:
	if not data.empty():
		$Panel/MarginContainer/VBoxContainer/TopBar/Label.set_text("Recette : " + data.title)
		
		# Title
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/HBoxContainer/Title").set_text(data.title)
		# Author
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Author").set_text(data.author)
		# Category
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Category/Label").set_text(data.category)
	else:
		push_error("DISPLAY RECIPE VOID") #TODO

# Signal functions

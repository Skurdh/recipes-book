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
		$Panel/MarginContainer/VBoxContainer/Label.set_text(String(data))
	else:
		push_error("DISPLAY RECIPE VOID") #TODO


# Signal functions

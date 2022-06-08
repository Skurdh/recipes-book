"""
Script : NAME

"""

extends MarginContainer

# Signals
signal deleted()
signal updated()
# Export variable

# Public variables
var data: Dictionary = {}

# Onready variables


# Setter Getter Functions

# Callback functions

# Self functions
func populate(n_data: Dictionary, color: Color)-> void:
	if not data.empty():
		emit_signal("updated")
	data = n_data.duplicate()
	$HBoxContainer/Label.set_text(data.title)
	$HBoxContainer/Label.set("custom_colors/font_color", color)


func get_view_button() -> Button:
	var button: Button = $HBoxContainer/Button
	return button


# Signal functions
func _on_tree_exited() -> void:
	emit_signal("deleted")

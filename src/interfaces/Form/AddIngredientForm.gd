"""
Script : NAME

"""

extends PanelContainer

# Signals
signal data_collected(data)


# Export variable
export(int, "RECIPE", "LIST") var mode: int = 0

# Public variables

# Onready variables


# Setter Getter Functions

# Callback functions
func _ready() -> void:
	if mode == 1:
		$VBoxContainer/HBoxContainer2/SelectField.set_visible(true)

# Self functions


# Signal functions
func _on_Form_data_collected(data: Array) -> void:
	var ingredient_data: Dictionary = {}
	
	for entry in data:
		var content = entry.content
		if typeof(content) == TYPE_INT or typeof(content) == TYPE_STRING and not content.empty():
			ingredient_data[entry.id] = content 
	
	if ingredient_data.has("link_r") and mode == 0:
		ingredient_data.erase("link_r")
	
	

"""
Script : NAME

"""

extends VBoxContainer

# Signals

# Export variable
export(Array, String) var types: Array = []
# Public variables

# Onready variables


# Setter Getter Functions

# Callback functions
func _ready() -> void:
	$Label.set_text(types[0])
	
# Self functions

# Signal functions

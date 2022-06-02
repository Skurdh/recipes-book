"""
Script : NAME

"""

extends Node

# Signals

# Export variable

# Public variables
var fruit_library: Array = ["Abricot", "Airelle", "Amande", "Ananas", "Avocat", "Banane"]
var adjective_library: Array = ["Mysterieux", "duDemon", "Bonbon", "Sanguine", "Poilu", "Démoniaque"]

# Onready variables


# Setter Getter Functions

# Callback functions

# Self functions
func generate() -> String:
	randomize()
	return fruit_library[randi() % fruit_library.size()] + adjective_library[randi() % fruit_library.size()]
	



# Signal functions

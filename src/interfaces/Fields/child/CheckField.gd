"""
Script : NAME

"""

extends Field

# Signals

# Export variable
export(String) var title: String = ""

# Public variables

# Onready variables
onready var check_box: CheckBox = $HBoxContainer/CheckBox

# Setter Getter Functions

# Callback functions
func _ready() -> void:
	$HBoxContainer/Label.set_text(title)
	yield(get_tree(), "idle_frame")
	set_custom_minimum_size($HBoxContainer.get_size())


# Self functions
func set_data(value: bool) -> void:
	check_box.set_pressed(value)
	
	
func get_data() -> bool:
	return check_box.is_pressed()
	

func clear_field() -> void:
	check_box.set_pressed(false)


# Signal functions

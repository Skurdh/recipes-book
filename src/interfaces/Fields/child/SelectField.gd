"""
Script : NAME

"""
extends ComplexField

# Signals

# Export variable
export(Array, String) var options: Array = []
export(String) var default_option = ""

# Public variables

# Onready variables
onready var option_button: OptionButton = $HBoxContainer2/OptionButton

# Setter Getter Functions

# Callback functions
func _ready() -> void:
	if default_option.empty():
		option_button.add_item("- Sélectionner -")
		option_button.set_item_disabled(0, true)
	else:
		option_button.set_text(default_option)
		option_button.add_item(default_option)
		
	for option_name in options: 
		option_button.add_item(option_name)


# Self functions
func add_option(name: String) -> void:
	option_button.add_item(name)


func set_data(value: int) -> void:
	option_button.select(value)


func get_data() -> int:
	return option_button.get_selected_id()


func clear_field() -> void:
	.clear_field()
	option_button.select(0)


func push_field_error() -> void:
	print_error(errors_list[0])

	
func is_empty() -> bool:
	if option_button.selected == 0 and default_option.empty():
		return true
	else:
		return false


# Signal functions
func _on_OptionButton_item_selected(index):
	_on_FieldControl_focus_exited()



"""
Script : NAME

"""

extends ComplexField

# Signals

# Export variable

# Public variables
var selected_months: Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var full_selection: bool = false

# Onready variables
onready var months_root: HBoxContainer = $HBoxContainer2/VBoxContainer/MonthRoot
onready var all_button: Button = $HBoxContainer2/VBoxContainer/All
# Setter Getter Functions

# Callback functions
func _ready() -> void:
	for i in months_root.get_child_count():
		months_root.get_child(i).connect("toggled", self, "_on_MonthButton_toggled", [i])


# Self functions
func push_field_error() -> void:
	print_error(errors_list[0])


func is_empty() -> bool:
	for state in selected_months:
		if state == 1:
			return false
	return true


func set_data(value: String) -> void:
	if value.length() != 12:
		clear_field()
		return
	
	var i: int = 0
	for state_char in value:
		selected_months[i] = int(state_char)
		months_root.get_child(i).set_pressed(bool(selected_months[i]))
		i+= 1


func get_data() -> String:
	var data: String
	for state in selected_months:
		data += String(state)
	
	return data if data.length() == 12 else "000000000000"


func clear_field() -> void:
	.clear_field()
	all_button.set_pressed(false)


# Signal functions
func _on_MonthButton_toggled(button_pressed: bool, idx: int) -> void:
	selected_months[idx] = int(button_pressed)
	
	_on_FieldControl_focus_exited()
	
	if not full_selection and selected_months.find(0) == -1:
		full_selection = true
		all_button.set_pressed(true)
	elif full_selection and selected_months.find(0) != -1:
		full_selection = false
		all_button.set_pressed(false)


func _on_All_pressed() -> void:
	var is_pressed: bool = all_button.is_pressed()
	for i in selected_months.size():
		if is_pressed and selected_months[i] == 0:
			months_root.get_child(i).set_pressed(true)
		elif not is_pressed and selected_months[i] == 1:
			months_root.get_child(i).set_pressed(false)

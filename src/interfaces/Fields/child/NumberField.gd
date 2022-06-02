"""
Script : NAME

"""
tool
extends ComplexField

# Signals

# Export variable

# Public variables

# Onready variables
onready var spin_box: SpinBox = $HBoxContainer2/SpinBox
onready var error_stylebox: StyleBoxFlat = preload("res://assets/themes/AutoCompletion_Error_StyleBox.tres")

# Setter Getter Functions

# Callback functions
func _ready() -> void:
# warning-ignore:return_value_discarded
	spin_box.get_line_edit().connect("focus_entered", self, "_on_LineEdit_focus_entered")

# Self functions
func set_data(value: float) -> void:
	$HBoxContainer2/SpinBox.set_value(value)


func get_data() -> float:
	return spin_box.get_value()


func clear_field() -> void:
	.clear_field()
	spin_box.set_value(0.0)


func push_field_error() -> void:
	if title_container.is_visible():
		print_error(errors_list[0])
	else:
		spin_box.get_line_edit().set("custom_styles/normal", error_stylebox)


func is_empty() -> bool:
	return false
#	if spin_box == 0:
#	if line_edit.text == "0" or line_edit.text == "":
#		return true
#	else:
#		return false


# Signal functions
func _on_LineEdit_focus_entered() -> void:
	var line_edit: LineEdit = spin_box.get_line_edit()
	line_edit.set("custom_styles/normal", null)
#	line_edit.set_text("0")
#	line_edit.clear()

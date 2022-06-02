"""
Script : NAME

"""
tool
extends ComplexField

# Signals

# Export variable
export(String) var placeholder_text: String = ""

# Public variables

# Onready variables
onready var line_edit: LineEdit = $HBoxContainer2/LineEdit
onready var error_stylebox: StyleBoxFlat = preload("res://assets/themes/AutoCompletion_Error_StyleBox.tres")

# Setter Getter Functions

# Callback functions
func _ready() -> void:
	line_edit.set_placeholder(placeholder_text)

# Self functions
func push_field_error() -> void:
	if title_container.is_visible():
		print_error(errors_list[0])
	else:
		line_edit.set("custom_styles/normal", error_stylebox)


func set_data(value: String) -> void:
	line_edit.set_text(value)


func get_data() -> String:
	return line_edit.text


func is_empty() -> bool:
	return true if line_edit.text == "" else false


func clear_field() -> void:
	.clear_field()
	line_edit.set_text("")


# Signal functions
func _on_LineEdit_focus_entered() -> void:
	line_edit.set("custom_styles/normal", null)


func _on_LineEdit_text_changed(_new_text: String):
	_on_FieldControl_focus_exited()

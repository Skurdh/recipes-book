"""
Script : NAME

"""

extends ComplexField

# Signals

# Export variable
export(bool) var separated_lines: bool = false

# Public variables

# Onready variables
onready var text_edit: TextEdit = $HBoxContainer2/TextEdit


# Setter Getter Functions

# Callback functions

# Self functions
func export_text(text: String) -> Array:
	if not separated_lines:
		return [text]
	else:
		var sub_text: String = text
		var lines: Array = []

		while not sub_text.empty():
			var pos: int = sub_text.find("\n", 0)
			if pos != -1:
				var paragraph: String = sub_text.substr(0, pos)
				if not paragraph.empty() and paragraph != "\n":
					lines.append(paragraph)
				sub_text.erase(0, paragraph.length() + 1)
			else:
				lines.append(sub_text)
				sub_text = ""
		
		return lines


func set_data(value: Array) -> void:
	var size: int = value.size()
	for i in range(size):
		if i == 0:
			text_edit.set_text(text_edit.text + value[i])
		else:
			text_edit.set_text(text_edit.text + "\n\n" + value[i])


func get_data() -> Array:
	return export_text(text_edit.get_text())


func clear_field() -> void:
	.clear_field()
	text_edit.set_text("")


func push_field_error() -> void:
	print_error(errors_list[0])


func is_empty() -> bool:
	if text_edit.get_text().empty():
		return true
	else:
		return false



# Signal functions
func _on_TextEdit_text_changed():
	_on_FieldControl_focus_exited()

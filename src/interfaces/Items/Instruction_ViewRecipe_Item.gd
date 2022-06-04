"""
Script : NAME

"""

extends PanelContainer

# Signals

# Export variable

# Public variables
const COLOR = [Color(0.8, 0.807843, 0.827451), Color(0.32549, 0.337255, 0.376471)]
var step: String = ""

# Onready variables
onready var rich_text_label: RichTextLabel = $MarginContainer/HBoxContainer/RichTextLabel
onready var step_label: Label = $MarginContainer/HBoxContainer/Label

# Setter Getter Functions

# Callback functions

# Self functions
func populate(idx: int, data: String) -> void:
	step_label.set_text(String(idx) + ".")
	step = data
	rich_text_label.set_bbcode(data)
	rich_text_label.set("custom_colors/default_color", COLOR[0])
	step_label.set("custom_colors/font_color", COLOR[0])


# Signal functions
func _on_Button_toggled(button_pressed: bool) -> void:
	if button_pressed:
		rich_text_label.set_bbcode("[s]" + step + "[/s]")
		rich_text_label.set("custom_colors/default_color", COLOR[1])
		step_label.set("custom_colors/font_color", COLOR[1])
	else:
		rich_text_label.set_bbcode(step)
		rich_text_label.set("custom_colors/default_color", COLOR[0])
		step_label.set("custom_colors/font_color", COLOR[0])
		

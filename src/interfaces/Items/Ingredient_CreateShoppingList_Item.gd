"""
Script : NAME

"""

extends MarginContainer

# Signals
signal deleted()
signal updated()
# Export variable

# Public variables
var data: Dictionary = {}

# Onready variables
onready var quantity_label: Label = $HBoxContainer/MarginContainer/HBoxContainer/Quantity
onready var ingredient_text: RichTextLabel = $HBoxContainer/MarginContainer/HBoxContainer/Ingredient
onready var strike: HSeparator = $HBoxContainer/MarginContainer/Strike


# Setter Getter Functions

# Callback functions

# Self functions
func populate(new_data: Dictionary, color: Color) -> void:
	if not data.empty():
		emit_signal("updated")
	var rich_text: RichTextLabel = ingredient_text if ingredient_text != null else $HBoxContainer/MarginContainer/HBoxContainer/Ingredient
	var label: Label = quantity_label if quantity_label != null else $HBoxContainer/MarginContainer/HBoxContainer/Quantity
	rich_text.set("custom_colors/default_color", color)
	label.set("custom_colors/font_color", color)
	data = new_data.duplicate()
	data.link_r = new_data.link_r
	data.pressed = false
	rich_text.bbcode_text = ""
	rich_text.bbcode_text += data.ingredient
	if data.has("quantity") and data.quantity != 0:
		label.set_text(String(data.quantity) + " " + data.unit if data.has("unit") else "")
	if data.has("add"):
		rich_text.bbcode_text += "  [i]" + data.add + "[/i]"


func get_edit_button() -> Button:
	var button: Button = $HBoxContainer/Edit
	return button


# Signal functions
func _on_Delete_pressed() -> void:
	queue_free()




func _on_CheckBox_toggled(button_pressed: bool) -> void:
	data.pressed = button_pressed
	if button_pressed:
		quantity_label.set_modulate(Color(0.533333, 0.533333, 0.533333))
		ingredient_text.set_modulate(Color(0.533333, 0.533333, 0.533333))
		strike.set_visible(true)
		get_edit_button().set_visible(false)
	else:
		quantity_label.set_modulate(Color(1, 1, 1))
		ingredient_text.set_modulate(Color(1, 1, 1))
		strike.set_visible(false)
		get_edit_button().set_visible(true)


func _on_tree_exited() -> void:
	emit_signal("deleted")

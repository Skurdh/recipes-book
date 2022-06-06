"""
Script : NAME

"""

extends ComplexField

# Signals

# Export variable

# Public variables
var time: Array = [0, 0]

# Onready variables
onready var select_button: Button = $HBoxContainer2/SelectButton
onready var popup_panel: PopupPanel = $HBoxContainer2/SelectButton/PopupPanel
onready var hour_spinbox: SpinBox = $HBoxContainer2/SelectButton/PopupPanel/MarginContainer/HBoxContainer/HourVBoxContainer/HourSpinBox
onready var min_spinbox: SpinBox = $HBoxContainer2/SelectButton/PopupPanel/MarginContainer/HBoxContainer/MinuteVBoxContainer2/MinuteSpinBox

# Setter Getter Functions

# Callback functions
func _ready() -> void:
# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", self, "_on_Viewport_size_changed")
	
	var line_edits: Array = [$HBoxContainer2/SelectButton/PopupPanel/MarginContainer/HBoxContainer/HourVBoxContainer/HourSpinBox.get_line_edit(), $HBoxContainer2/SelectButton/PopupPanel/MarginContainer/HBoxContainer/MinuteVBoxContainer2/MinuteSpinBox.get_line_edit()]
	for i in range(line_edits.size()):
		var line_edit: LineEdit = line_edits[i]
# warning-ignore:return_value_discarded
		line_edit.connect("focus_entered", self, "_on_LineEdit_focus_entered", [line_edit])
		line_edit.set_focus_next(line_edits[(i+1)%2].get_path())
		line_edit.set_focus_previous(line_edits[(i+1)%2].get_path())
		for j in range(4):
			line_edit. set_focus_neighbour(j, line_edits[(i+1)%2].get_path())
	
	line_edits[1].connect("text_entered", self, "_on_MinuteLineEdit_text_entered")
	
	
	


# Self functions
func time_format(value: int) -> String:
	if value < 10:
		return "0" + String(value)
		
	return String(value)


func get_popup_rect() -> Rect2:
	var button_global_rect: Rect2 = select_button.get_global_rect()
	
	return Rect2(button_global_rect.position + Vector2(-1, 36), Vector2(button_global_rect.size.x, 120))


func set_data(value: Array) -> void:
	time[0] = value[0]
	time[1] = value[1]
	select_button.set_text(time_format(time[0]) + " : " + time_format(time[1]))


func get_data() -> Array:
	return time


func clear_field() -> void:
	.clear_field()
	select_button.set_text("00 : 00")


func push_field_error() -> void:
	pass


func is_empty() -> bool:
	return false


# Signal functions
func _on_SelectButton_pressed() -> void:
	popup_panel.popup(get_popup_rect())
	hour_spinbox.set_value(time[0])
	min_spinbox.set_value(time[1])
	

func _on_LineEdit_focus_entered(node: LineEdit) -> void:
	yield(get_tree(), "idle_frame")
	node.select_all()


func _on_Viewport_size_changed() -> void:
	if popup_panel.is_visible():
		yield(get_tree(), "idle_frame")
		popup_panel.popup(get_popup_rect())


func _on_Validate_pressed() -> void:
	time[0] = int(hour_spinbox.get_value())
	time[1] = int(min_spinbox.get_value())
	
	select_button.grab_focus()
	select_button.set_pressed(false)
	select_button.set_text(time_format(time[0]) + " : " + time_format(time[1]))
	popup_panel.set_visible(false)
	_on_FieldControl_focus_exited()


func _on_PopupPanel_popup_hide() -> void:
	select_button.grab_focus()
	select_button.set_pressed(false)


func _on_MinuteLineEdit_text_entered(new_text: String) -> void:
	min_spinbox.set_value(int(new_text))
	_on_Validate_pressed()

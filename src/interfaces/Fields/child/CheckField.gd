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
func is_empty() -> bool:
	return not check_box.is_pressed()


func set_data(value: bool) -> void:
	check_box.set_pressed(value)
	
	
func get_data() -> bool:
	return check_box.is_pressed()
	

func clear_field() -> void:
	check_box.set_pressed(false)


# Signal functions
func _on_CheckBox_pressed() -> void:
	if has_content:
		if field_content == check_box.is_pressed():
			emit_signal("content_modified", "deleted")
			return

	emit_signal("content_modified", "added")

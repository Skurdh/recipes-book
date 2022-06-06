"""
Script : NAME

"""

extends Popup
class_name CustomPopup

# Signals
signal closed()

# Export variable
export(String) var page_name: String = ""
export(bool) var can_enlarge: bool = true

# Public variables
#var showed: bool = false
var enlarged: bool = false

# Onready variables

# Setter Getter Functions

# Callback functions
func _ready() -> void:
	if not can_enlarge:
		$Panel/MarginContainer/VBoxContainer/TopBar/Enlarge.set_visible(false)
# warning-ignore:return_value_discarded
#	connect("about_to_show", self, "_on_about_to_show")
# warning-ignore:return_value_discarded
#	connect("popup_hide", self, "_on_popup_hide")
# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", self, "_on_Viewport_size_changed")
	$Panel/MarginContainer/VBoxContainer/TopBar/Label.set_text(page_name)


# Self functions
func init(_data: Dictionary) -> void:
	pass


func custom_popup_centered() -> void:
#	if not showed:
	popup()
	
	var viewport_size: Vector2 = get_viewport().get_size()
	var popup_size: Vector2 = Vector2(max(rect_min_size.x, viewport_size.x - viewport_size.x * 16 / 100 * 2), max(rect_min_size.y, viewport_size.y - 52)) if not enlarged else Vector2(viewport_size.x - 52, viewport_size.y - 52) 
	var popup_position: Vector2 = Vector2(viewport_size.x / 2 - popup_size.x / 2, 26) if not enlarged else Vector2(26, 26)
	
	_set_position(popup_position)
	_set_size(popup_size)


func refresh() -> void:
	pass


# Signal functions
func _on_Viewport_size_changed() -> void:
#	if showed:
	custom_popup_centered()
	
	
func _on_Close_pressed() -> void:
	set_visible(false)
	queue_free()
	emit_signal("closed")


func _on_Enlarge_pressed() -> void:
	enlarged = not enlarged
	custom_popup_centered()


#func _on_about_to_show() -> void:
#	showed = true

#
#func _on_popup_hide() -> void:
#	_on_Close_pressed()

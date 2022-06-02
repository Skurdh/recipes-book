"""
Script : NAME

"""
tool
extends Field
class_name ComplexField

# Signals



# Export variable
export(String) var title: String = "" setget set_title
export(bool) var title_visible: bool = true setget set_title_visible
export(bool) var tooltip_activated: bool = false
export(String, MULTILINE) var tooltip_infos: String = ""
export(NodePath) var field_nodepath: NodePath


# Public variables
const errors_list: Array = [
	"Requis !"
]

var has_content: bool = false
var field_content #:Variant


# Onready variables
onready var title_container: HBoxContainer = $HBoxContainer
onready var error_label: Label = $HBoxContainer/Error
onready var tooltip_texture: TextureRect = $HBoxContainer/TooltipTextureRect


# Setter Getter Functions
func set_title(value: String) -> void:
	title = value
	$HBoxContainer/Title.set_text(value)


func set_title_visible(value: bool) -> void:
	title_visible = value
	$HBoxContainer.set_visible(title_visible)



# Callback functions
func _ready() -> void:	
	assert(field_nodepath != null, "Field Nodepath is null !")
# warning-ignore:return_value_discarded
	if field_nodepath != "":
		get_node(field_nodepath).connect("focus_exited", self, "_on_FieldControl_focus_exited")
	$HBoxContainer/Title.set_text(title)
	title_container.set_visible(title_visible)
	if tooltip_activated:
		tooltip_texture.set_tooltip(tooltip_infos)
		tooltip_texture.set_visible(true)



# Self functions
func push_field_error() -> void:
	print("Must be overrided !")
	pass


func print_error(error_text: String) -> void:
	error_label.set_text(error_text)


func clear_error() -> void:
	error_label.set_text("")


func is_empty() -> bool:
	print("Must be overrided !")
	return true


func check(ignore_error: bool) -> bool:
	clear_error()
	
	if is_empty() and is_required:
		if not ignore_error:
			push_field_error()
		return false
	return true


func inject_data(content_data) -> void:
	has_content = true
	field_content = content_data
	set_data(content_data)
	
	
func collect(ignore_error: bool = false) -> Dictionary:
	if check(ignore_error):
		return {"id": field_id, "content": get_data()}
	else:
		return {}


func clear_field() -> void:
	if has_content:
		has_content = false
		field_content = null



# Signal functions
func _on_TooltipTextureRect_mouse_entered() -> void:
	tooltip_texture.set_modulate(Color(0.839216, 0.85098, 0.87451))


func _on_TooltipTextureRect_mouse_exited() -> void:
	tooltip_texture.set_modulate(Color(0.654902, 0.67451, 0.713726))


func _on_FieldControl_focus_exited() -> void:
	if has_content:
		if check(false) and get_data() != field_content:
			emit_signal("content_modified", "added")
			return
	else:
		if check(false):
			emit_signal("content_modified", "added")
			return

	emit_signal("content_modified", "deleted")

"""
Script : NAME

"""
extends VBoxContainer
class_name Field

# Signals
signal content_modified(state)


# Export variable
export(String) var field_id: String = ""
export(bool) var is_required: bool = true

# Public variables
var has_content: bool = false
var field_content #:Variant


# Onready variables


# Setter Getter Functions

# Callback functions
func _ready() -> void:
	pass
#	assert(field_id != "", name + " has field ID empty !")
	

# Self functions
func inject_data(content_data) -> void:
	has_content = true
	field_content = content_data
	set_data(content_data)


func is_empty() -> bool:
	print("Must be overrided !")
	return true


func set_data(value) -> void:
	print("Must be overrided !")


func get_data():
	print("Must be overrided !")
	

func collect(_ignore_error: bool = false) -> Dictionary:
	return {"id": field_id, "content": get_data()}


func clear_field() -> void:
	print("Must be overrided !")
	

# Signal functions

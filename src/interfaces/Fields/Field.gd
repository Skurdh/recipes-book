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

# Onready variables


# Setter Getter Functions

# Callback functions
func _ready() -> void:
	pass
#	assert(field_id != "", name + " has field ID empty !")
	

# Self functions
func set_data(value) -> void:
	print("Must be overrided !")


func get_data():
	print("Must be overrided !")
	

func collect(_ignore_error: bool = false) -> Dictionary:
	return {"id": field_id, "content": get_data()}


func clear_field() -> void:
	print("Must be overrided !")
	

# Signal functions

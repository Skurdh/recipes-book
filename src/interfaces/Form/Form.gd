"""
Script : NAME

"""
extends Node
class_name Form

# Signals
signal data_collected(data)
signal form_completed()


# Export variable
export(int, "NONE", "ADD", "MODIFY") var mode: int = 0
export(Array, NodePath) var fields: Array = []
export(NodePath) var validation_button: NodePath

# Public variables
enum Field { VOID, ADDED }
var fields_state: Array = []

# Onready variables

# Setter Getter Functions

# Callback functions
func _ready() -> void:
# warning-ignore:return_value_discarded
	assert(fields.size() > 0, "Form fields is empty.")
	get_node(validation_button).connect("pressed", self, "_on_ValidationButton_pressed")
	if mode != 0:
		get_node(validation_button).set_disabled(true)
	for field_path in fields:
		var field: Field = get_node(field_path)
# warning-ignore:return_value_discarded
		field.connect("content_modified", self, "_on_Field_content_modified", [field_path])
		fields_state.append([field.is_required, Field.VOID])


# Self functions
func collect(ignore_error: bool = false) -> Array:
	var collect: Array = []
	var has_error: bool = false
	
	for field_nodepath in fields:
		var field_node: Node = get_node(field_nodepath)
		var data: Dictionary = field_node.collect(ignore_error)
		if not data.empty():
			collect.append(data)
		else:
			has_error = true
	
	if has_error and not ignore_error:
		return []
	else:
		return collect


func clear() -> void:
	for field_nodepath in fields:
		get_node(field_nodepath).clear_field()
	for state in fields_state:
		state[1] = Field.VOID
	

func verify_fields_state() -> void:
	if mode == 1: #ADDED MODE
		for state in fields_state:
			if state[0] and state[1] == Field.VOID:
				get_node(validation_button).set_disabled(true)
				return
	elif mode == 2: #MODIFY MODE
		var field_is_added: bool = false
		for state in fields_state:
			if state[0] and state[1] == Field.ADDED:
				field_is_added = true
				break
		if not field_is_added:
			get_node(validation_button).set_disabled(true)
			return
	
	emit_signal("form_completed")
	get_node(validation_button).set_disabled(false)
	
	
	
# Signal functions
func _on_ValidationButton_pressed() -> void:
	var data: Array = collect()
			
	if not data.empty():
		clear()
		if mode != 0:
			get_node(validation_button).set_disabled(true)
		emit_signal("data_collected", data)


func _on_Field_content_modified(state: String, field_path: NodePath) -> void:
	if mode == 0: return
	
	var field_idx: int = fields.find(field_path)
	if field_idx != -1:
		fields_state[field_idx][1] = Field.ADDED if state == "added" else Field.VOID
	verify_fields_state()

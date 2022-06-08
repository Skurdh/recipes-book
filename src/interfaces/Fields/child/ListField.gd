"""
Script : NAME

"""
extends ComplexField

# Signals

# Export variable

# Public variables

# Onready variables
onready var list_root: VBoxContainer = $HBoxContainer2/Panel/MarginContainer/ScrollContainer/VBoxContainer


# Setter Getter Functions

# Callback functions

# Self functions
func add_item(item: Control) -> void:
	list_root.add_child(item)
	item.connect("tree_exited", self, "_on_Item_tree_exited")
	item.connect("updated", self, "_on_Item_updated")
	_on_FieldControl_focus_exited()


func push_field_error() -> void:
	print_error(errors_list[0])


func is_empty() -> bool:
	return list_root.get_child_count() == 0


func set_data(value: Array) -> void:
	for item in value: 
		list_root.add_child(item)


func get_data() -> Array:
	var items: Array = []
	for child in list_root.get_children():
		items.append(child)
	
	return items
	

func clear_field() -> void:
	.clear_field()
	for child in list_root.get_children():
		child.queue_free()


func _on_FieldControl_focus_exited() -> void:
	if check(false):
		emit_signal("content_modified", "added")
		return

	emit_signal("content_modified", "deleted")


# Signal functions
func _on_Item_tree_exited() -> void:
	_on_FieldControl_focus_exited()


func _on_Item_updated() -> void:
	_on_FieldControl_focus_exited()

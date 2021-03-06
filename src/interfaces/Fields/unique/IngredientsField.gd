"""
Script : NAME

"""

extends ComplexField

# Signals

# Export variable

# Public variables

# Onready variables
onready var units_field: VBoxContainer = $HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/UnitField
onready var ingredients_field: VBoxContainer = $HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/IngredientField
onready var ingredient_item: PackedScene = preload("res://src/interfaces/Items/IngredientItem.tscn")
onready var grid_container: GridContainer = $HBoxContainer2/VBoxContainer/Panel/MarginContainer/ScrollContainer/GridContainer

# Setter Getter Functions

# Callback functions
func _ready() -> void:
#	yield(save_indexes(), "completed")
	load_indexes()


# Self functions
#func save_indexes() -> void:	
#	var file: File = File.new()
#	var local_data: Dictionary = {}
#
#	var index_collection: FirestoreCollection = Firebase.Firestore.collection("indexes")
#	var ingredients_doc: FirestoreDocument = yield(index_collection.get("ingredients"), "get_document")
#	local_data["ingredients"] = ingredients_doc.doc_fields
#
#	var units_doc: FirestoreDocument = yield(index_collection.get("units"), "get_document")
#	local_data["units"] = units_doc.doc_fields
#
#	var file_error: int = file.open("user://LOCAL_indexes.data", File.WRITE)
#	if file_error == OK:
#		file.store_var(local_data)
#		file.close()
#	else:
#		push_error("ERROR FILE.") #TODO


func load_indexes() -> void:
	var file: File = File.new()
	var file_error: int = file.open("user://LOCAL_indexes.data", File.READ)
	if file_error == OK:
		var indexes: Dictionary = file.get_var()
		
		units_field.index = indexes.units
		units_field.set_editable(true)
		ingredients_field.index = indexes.ingredients
		ingredients_field.set_editable(true)
		
		file.close()
	else:
		push_error("ERROR FILE.") #TODO


func unload_indexes() -> void:
	units_field.index.clear()
	ingredients_field.index.clear()



func set_data(value: Array) -> void:
	for ing in value:
		var item: Control = ingredient_item.instance()
		item.populate(ing)
		item.connect("deleted", self, "_on_FieldControl_focus_exited")
		grid_container.add_child(item)


func get_data() -> Array:
	var ingredients: Array = []
	for child in grid_container.get_children():
		ingredients.append(child.data)
	return ingredients


func clear_field() -> void:
	.clear_field()
	for child in grid_container.get_children():
		child.queue_free()
	$Form.clear()


func push_field_error() -> void:
	print_error("Aucun ingr??dient ajout??.")


func is_empty() -> bool:
	if grid_container.get_child_count() == 0:
		return true
	return false


func _is_data_same_as_fieldcontent() -> bool:
	for new_ing in get_data():
		for content_ing in field_content:
			for key in new_ing.keys():
				if content_ing.has(key) and new_ing[key] != content_ing[key]:
					return false
	return true


func _on_FieldControl_focus_exited() -> void:
	if has_content:
		if check(false) and not _is_data_same_as_fieldcontent():
			emit_signal("content_modified", "added")
			return
	else:
		if check(false):
			emit_signal("content_modified", "added")
			return

	emit_signal("content_modified", "deleted")


# Signal functions
func _on_Form_data_collected(data: Array) -> void:
	var ingredient_dic: Dictionary = {}
	for field in data:
		if typeof(field.content) != TYPE_STRING or typeof(field.content) == TYPE_STRING and not field.content.empty():
			ingredient_dic[field.id] = field.content
	
	var item: Control = ingredient_item.instance()
	item.populate(ingredient_dic)
	item.connect("deleted", self, "_on_FieldControl_focus_exited")
	grid_container.add_child(item)
	
	_on_FieldControl_focus_exited()

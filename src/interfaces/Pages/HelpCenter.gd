"""
Script : NAME

"""

extends CustomPopup

# Signals

# Export variable

# Public variables
const _bug_report_document: Dictionary = {"where":"", "descr":"", "author":"", "author_id":"","date":""}
const _feedback_report_document: Dictionary = {"descr":"", "author":"", "author_id":"","date":""}
const _unit_suggestion_document: Dictionary = {"name":"", "abbr":"", "author":"", "author_id":"","date":""}
const _ingredient_suggestion_document: Dictionary = {"name":"", "author":"", "author_id":"","date":""}

# Onready variables
onready var menu_root: MarginContainer = $Panel/MarginContainer/VBoxContainer/MarginContainer
onready var form_root: VBoxContainer = $Panel/MarginContainer/VBoxContainer/MarginContainer2/FormRoot
onready var validation_root: MarginContainer = $Panel/MarginContainer/VBoxContainer/MarginContainer3

# Setter Getter Functions

# Callback functions


# Self functions
func display_form_page(idx: int) -> void:
	$Panel/MarginContainer/VBoxContainer/MarginContainer2.set_visible(true)
	menu_root.set_visible(false)
	form_root.get_child(idx).set_visible(true)


func display_validation(text: String) -> void:
	$Panel/MarginContainer/VBoxContainer/MarginContainer2.set_visible(false)
	validation_root.set_visible(true)
	validation_root.get_node("VBoxContainer/Label").set_text(text)


func update_document(data: Array, path: String, document: Dictionary, validation_msg: String) -> void:
	display_loading(true, "Envoi au support...")
	var support_collection = Firebase.Firestore.collection("support")
	var new_data: Dictionary = {}
	for entry in data:
		if document.has(entry.id):
			new_data[entry.id] = entry.content
	if not new_data.empty():
		new_data.author = Profil.get_username()
		new_data.author_id = Profil.get_id()
		var date: Dictionary = OS.get_datetime()
		new_data.data = "%s-%s-%sT%s:%s:%s" % [date.year, date.month, date.day, date.hour, date.minute, date.second]
		
		support_collection.get(path)
		var support_doc: FirestoreDocument = yield(support_collection, "get_document")
		var current_data: Array = support_doc.doc_fields.new
		current_data.append(new_data)
		var update_task: FirestoreTask = support_collection.update(path, {"new":current_data})
		yield(update_task, "task_finished")
		display_loading(false)
		display_validation(validation_msg)
		


# Signal functions
func _on_Bug_pressed() -> void:
	display_form_page(0)


func _on_Suggestion_pressed() -> void:
	display_form_page(1)


func _on_Unit_pressed() -> void:
	display_form_page(2)


func _on_Ingredient_pressed() -> void:
	display_form_page(3)


func _on_Form_aborted() -> void:
	$Panel/MarginContainer/VBoxContainer/MarginContainer2.set_visible(false)
	validation_root.set_visible(false)
	menu_root.set_visible(true)
	for child in form_root.get_children():
		child.set_visible(false)


func _on_Exit_pressed() -> void:
	_on_Close_pressed()


func _on_BugForm_data_collected(data: Array) -> void:
	update_document(data, "bug_reports", _bug_report_document, "Votre rapport a bien été transmis. Merci !")


func _on_SuggestionForm_data_collected(data: Array) -> void:
	update_document(data, "feedback_reports", _feedback_report_document, "Merci pour votre suggestion !")


func _on_UnitForm_data_collected(data: Array) -> void:
	update_document(data, "unit_suggestions", _unit_suggestion_document, "Votre proposition d'unité a été prise en compte. Merci !")


func _on_IngredientForm_data_collected(data: Array) -> void:
		update_document(data, "ingredient_suggestions", _ingredient_suggestion_document, "Votre proposition d'ingrédient a été prise en compte. Merci !")

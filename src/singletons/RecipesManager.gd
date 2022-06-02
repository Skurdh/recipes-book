"""
Script : NAME

"""
extends Node

# Signals
signal request_finished(task_infos)

# Export variable

# Public variables
enum {OK, VOID_DATA}

const _recipe_document_body: Dictionary = {
#	"creation_date": "",
	"author": "",
	"author_id": "",
	"title": "",
	"photo_id": "",
	"category": 0,
	"season": 0,
	"diet": 0,
	"quality": 0,
	"portions": 0,
	"prep_time": [],
	"cook_time": [],
	"gluten_free": false,
	"milk_free": false,
	"with_sugar": false,
	"ingredients": [],
	"instructions": [],
	"notes": "",
	"reviews": [],
	"commentaries": []
}

var recipes_collection: FirestoreCollection
var recipes_loaded: Array = []
var recipes_count: int = 0

# Onready variables

# Setter Getter Functions

# Callback functions


# Self functions
func init_load() -> void:
	recipes_collection = Firebase.Firestore.collection("recipes")
# warning-ignore:return_value_discarded
	recipes_collection.connect("error", self, "_on_FirestoreCollection_error")
# warning-ignore:return_value_discarded
	recipes_collection.connect("add_document", self, "_on_FirestoreCollection_document_added")
# warning-ignore:return_value_discarded
	recipes_collection.connect("update_document", self, "_on_FirestoreCollection_document_updated")
# warning-ignore:return_value_discarded
	recipes_collection.connect("delete_document", self, "_on_FirestoreCollection_document_deleted")
	
	get_all_recipes()
	print(get_size())


func _sort_recipes_by_creation_date(a: Dictionary, b: Dictionary) -> bool:
	if a.create_time > b.create_time:
		return true
	return false


func _get_date_formated() -> String:
	var datetime: Dictionary = OS.get_datetime()
	var date_format: String = "YY-MM-DD_%h:%m:%s"
	
	return date_format.replace("DD", String(datetime.day).pad_zeros(2)).replace("MM", String(datetime.month).pad_zeros(2)).replace("YY", String(datetime.year).pad_zeros(4)).replace("%h", String(datetime.hour).pad_zeros(2)).replace("%m", String(datetime.minute).pad_zeros(2)).replace("%s", String(datetime.second).pad_zeros(2))


func _generate_recipe_data(doc: FirestoreDocument) -> Dictionary:
	var new_recipe: Dictionary = doc.doc_fields
	new_recipe.ID = doc.doc_name
	new_recipe.create_time = doc.document.createTime
	new_recipe.update_time = doc.document.updateTime
	
	return new_recipe


# TEMP
var user_id: Array = ["9wbcgkbQTkWi8RMMyjEZ2QxsClp1", "MgmgEoe6O3Pb8oPF98a74dnpfzj2", "avhF2StZgParFz6yIPh59C585Ny1 "]
var user_name: Array = ["JoJo", "BigLoki", "SKU"]


func add_recipe_doc(data: Array) -> void:
	print(data)
	var new_recipe_doc: Dictionary = {}
	
	for entry in data:
		if _recipe_document_body.has(entry.id): #and not entry.content.empty():
			new_recipe_doc[entry.id] = entry.content
	
	if not new_recipe_doc.empty():
		var i: int = randi() % 3
		new_recipe_doc.author = user_name[i]
		new_recipe_doc.author_id = user_id[i]
		new_recipe_doc.author = Profil.get_username()
		new_recipe_doc.author_id = Profil.get_id()
#		new_recipe_doc.creation_date = _get_date_formated()
		recipes_collection.add("", new_recipe_doc)
	else:
		emit_signal("request_finished", {"request_return": "add", "content": VOID_DATA})


func update_recipe_doc(id: String, data: Array) -> void:
	var updated_recipe_doc: Dictionary = {}
	
	for entry in data:
		if _recipe_document_body.has(entry.id) and not entry.content.empty():
			updated_recipe_doc[entry.id] = entry.content
			
	if not updated_recipe_doc.empty():
#		updated_recipe_doc.last_modify_date = _get_date_formated()
		recipes_collection.update(id, updated_recipe_doc)		
	else:
		emit_signal("request_finished", {"request_return": "update", "content": VOID_DATA})


func delete_recipe_doc(id: String) -> void:
	recipes_collection.delete(id)


func get_all_recipes() -> void:
	var list_task = Firebase.Firestore.list("recipes", 1000)
	var documents_list: Array = yield(list_task, "listed_documents")
	
	for doc in documents_list:
		recipes_loaded.append(_generate_recipe_data(doc))

	recipes_loaded.sort_custom(self, "_sort_recipes_by_creation_date")
	recipes_count = recipes_loaded.size()
	emit_signal("request_finished", {"request": "all", "content": OK})


func get_recipe_from_id(id: String) -> Dictionary:
	for recipe in recipes_loaded:
		if recipe.ID == id:
			return recipe
	
	return {}


func get_recipe_from_idx(idx: int) -> Dictionary:
	if idx >= 0 and idx < recipes_loaded.size():
		return recipes_loaded[idx]
	
	return {}


func get_recipes_from_author(author_id: String) -> Array:
	var recipes: Array = []
	
	for recipe in recipes_loaded:
		if recipe.author_id == author_id:
			recipes.append(recipe)
	
	recipes.sort_custom(self, "_sort_recipes_by_creation_date")
	return recipes


func get_recipes_from_pos(from: int, limit: int) -> Array:
	var recipes: Array = []
	var range_max: int = from + limit if from + limit <= recipes_count else recipes_count
	
	for i in range(from, range_max):
		recipes.append(recipes_loaded[i])
	
	return recipes


func get_size() -> int:
	return recipes_count



# Signal functions
func _on_FirestoreCollection_error(code, status, message) -> void:
	print("#ERROR", code, status, message)
	emit_signal("request_finished", {"request_return": "error", "content": false})


func _on_FirestoreCollection_document_added(document: FirestoreDocument) -> void:
	print(document)
	recipes_loaded.push_front(_generate_recipe_data(document))
	recipes_count = recipes_loaded.size()
#	recipes_loaded.sort_custom(self, "favorite_sort") #TODO
	emit_signal("request_finished", {"request_return": "add", "content": OK, "extra": document.doc_name})


func _on_FirestoreCollection_document_updated(_document: FirestoreDocument) -> void:
	print(_document)
	emit_signal("request_finished", {"request_return": "update", "content": OK})


func _on_FirestoreCollection_document_deleted() -> void:
	emit_signal("request_finished", {"request_return": "delete", "content": OK})

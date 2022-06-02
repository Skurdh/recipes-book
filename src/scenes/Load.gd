"""
Script : NAME

"""

extends Node

# Signals

# Export variable

# Public variables
const BATCH_FILE: String = """@echo off
cd %PATH
Start "" /b png2jpg_converter_v01.exe
"""
# Onready variables


# Setter Getter Functions

# Callback functions
func _ready() -> void:
	yield(Profil.get_profil(), "completed")
	RecipesManager.init_load()
	yield(RecipesManager, "request_finished")
	yield(local_save_indexes(), "completed")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/scenes/Home.tscn")
#
#
#	create_files_converter(check_files_converter())
#	create_files_local_recipes(check_files_local_recipes())

# Self functions
func local_save_indexes() -> void:
	yield(get_tree(), "idle_frame")
	var file: File = File.new()
	var local_data: Dictionary = {}

	var index_collection: FirestoreCollection = Firebase.Firestore.collection("indexes")
	var ingredients_doc: FirestoreDocument = yield(index_collection.get("ingredients"), "get_document")
	local_data["ingredients"] = ingredients_doc.doc_fields

	var units_doc: FirestoreDocument = yield(index_collection.get("units"), "get_document")
	local_data["units"] = units_doc.doc_fields

	var file_error: int = file.open("user://LOCAL_indexes.data", File.WRITE)
	if file_error == OK:
		file.store_var(local_data)
		file.close()
	else:
		push_error("ERROR FILE.") #TODO


func check_files_converter() -> Array:
	var dir: Directory = Directory.new()
	return [not dir.dir_exists("user://converter"), not dir.file_exists("user://converter/png2jpg_converter_v01.exe"), not dir.file_exists("user://converter/launch_convert.bat")]


func create_files_converter(files_check: Array) -> void: #TODO Loading SIGNAL, CHECK CORRUPTED FILES
	if files_check[0]: # DIR missing
		var dir: Directory = Directory.new()
		print("Création du dossier /converter.")
# warning-ignore:return_value_discarded
		dir.make_dir("user://converter")
	if files_check[1]: # Converter missing
		print("Téléchargement du compresseur d'image. (2.5 Mo)")
		var storage_task: StorageTask = Firebase.Storage.ref("recipe_images/converter/png2jpg_converter_v01.exe").get_data()
		yield(storage_task, "task_finished")

		var file: File = File.new()
# warning-ignore:return_value_discarded
		file.open("user://converter/png2jpg_converter_v01.exe", File.WRITE)
		file.store_buffer(storage_task.data)
		file.close()
		print("Téléchargement terminé")
	if files_check[2]: # Batch missing
		var file: File = File.new()
		print("Création du script BATCH.")
# warning-ignore:return_value_discarded
		file.open("user://converter/launch_convert.bat", File.WRITE)
		var batch_code: String = BATCH_FILE.replace("%PATH", OS.get_user_data_dir().replace("/", "\\") + "\\converter")
		file.store_string(batch_code)
		file.close()
		print("Téléchargement terminé")


func check_files_local_recipes() -> Array:
	var dir: Directory = Directory.new()
	return [not dir.dir_exists("user://local_recipes"), not dir.dir_exists("user://local_recipes/images")]


func create_files_local_recipes(files_check: Array) -> void: #TODO Loading SIGNAL, CHECK CORRUPTED FILES
	if files_check[0]: # DIR missing
		var dir: Directory = Directory.new()
		print("Création du dossier /local_recipes.")
# warning-ignore:return_value_discarded
		dir.make_dir("user://local_recipes")
	if files_check[1]: # DIR missing
		var dir: Directory = Directory.new()
		print("Création du dossier /local_recipes/images.")
# warning-ignore:return_value_discarded
		dir.make_dir("user://local_recipes/images")
	





# Signal functions


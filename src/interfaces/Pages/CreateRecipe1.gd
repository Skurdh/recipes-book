"""
Script : NAME

"""

extends CustomPopup

# Signals

# Export variable

# Public variables
const _new_recipe_document_body: Dictionary = {
	"RID": "",
	"author": "",
	"title": "",
	"photo_uuid": "",
	"photo_link": "",
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

const uuid_util = preload('res://src/ressources/uuid.gd')

var recipe_uuid: String

# Onready variables
onready var form: Form = $Form
onready var ingredient_field: Field = $Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/IngredientField
onready var image_field: Field = $Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/ImageField

onready var load_bg: ColorRect = $Load
onready var load_label: Label = $Load/VBoxContainer/Label
onready var load_timer: Timer = $Load/Timer

# Setter Getter Functions

# Callback functions
func _ready() -> void:
	pass
#	TODO : remove c
#	ingredient_field.save_indexes()


# Self functions
func compress_photo(image: Image) -> bool:
	yield(get_tree(), "idle_frame")
	if image.save_png("user://converter/recipe_image.png") == OK:
		if OS.shell_open(ProjectSettings.globalize_path("user://converter/launch_convert.bat")) == OK:
			var timer: float = 10.0
			var dir: Directory = Directory.new()

			while not dir.file_exists("user://converter/output/recipe_image.jpg") and timer > 0:
				yield(get_tree().create_timer(1.0), "timeout")
				timer -= 1.0

			if dir.file_exists("user://converter/output/recipe_image.jpg"):
				return true
	return false


# Signal functions
#func _on_Form_data_collected(_idx, data) -> void:
#	var new_recipe: Dictionary = _new_recipe_document_body.duplicate()
#	var photo: Image
#
#	load_bg.set_visible(true)
#	load_label.set_text("Publication de la recette...")
#
#	for d in data:
#		if new_recipe.has(d[0]):
#			new_recipe[d[0]] = d[1]
#		elif d[0] == "photo":
#			new_recipe.photo_uuid = d[1][0]
#			photo = d[1][1]
#	new_recipe.author = Profil.get_username()
#	new_recipe.RID = recipe_uuid
#
#	var collection: FirestoreCollection = Firebase.Firestore.collection("recipes")
#	var firestore_task: FirestoreTask = collection.add("", new_recipe)
#	yield(firestore_task, "add_document")
#
#	var compress_result: bool = yield(compress_photo(photo), "completed")
#	if compress_result:
#		new_recipe.photo_link = "recipe_images/upload/" + new_recipe.photo_uuid + ".jpg"
#		print(new_recipe.photo_link, " /", ProjectSettings.globalize_path("user://converter/output/recipe_image.jpg"))
#
#		var storage_task: StorageTask = Firebase.Storage.ref(new_recipe.photo_link).put_file("user://converter/output/recipe_image.jpg")
#		yield(storage_task, "task_finished")
#	else:
#		new_recipe.photo_link = "recipe_images/upload/missing_photo.jpg"
#
#	image_field.clear_images_files()
#	load_bg.set_visible(false)
#	load_label.set_text("")
#	set_visible(false)
#

func _on_CreateRecipe_about_to_show() -> void:
	recipe_uuid = uuid_util.v4()
	ingredient_field.load_indexes()


func _on_CreateRecipe_popup_hide() -> void:
	ingredient_field.unload_indexes()


func _on_Save_pressed() -> void:
	var data: Array = form.collect(true)
	
	if not data.size() > 6:
		$Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/TitleField.print_error("Impossible de sauvegarder, la recette est vide.") 
		return 
		
	var new_recipe: Dictionary = _new_recipe_document_body.duplicate()
	var photo: Image
	# Fill the recipe dictionnary with the form data
	var all_void: bool = true
	for d in data:
		if new_recipe.has(d[0]):
			new_recipe[d[0]] = d[1]
		elif d[0] == "photo":
			new_recipe.photo_uuid = d[1][0]
			photo = d[1][1]
	new_recipe.author = Profil.get_username()
	new_recipe.RID = recipe_uuid
	
	if not new_recipe.has("title") or new_recipe.title.empty():
		$Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/TitleField.print_error("Ajouter un titre pour sauvegarder la recette") 
		return 
	
	load_bg.set_visible(true)
	load_label.set_text("Sauvegarde du brouillon de la recette...")
	
	# Compress/Convert the recipe photo and copy them
	if photo != null:
		var compress_result: bool = yield(compress_photo(photo), "completed")
		var dir: Directory = Directory.new()
		new_recipe.photo_link = "user://local_recipes/images/" + new_recipe.photo_uuid + ".jpg"
		if compress_result:
			dir.copy("user://converter/output/recipe_image.jpg", new_recipe.photo_link)
		else:
			dir.copy("res://assets/textures/interfaces/missing_photo.jpg", new_recipe.photo_link)
	
	# Open/Save local recipes
	var file: File = File.new()
	var recipes_list: Array = []
	if file.file_exists("user://local_recipes/LOCAL_drafts.data"):
		var file_error: int = file.open("user://local_recipes/LOCAL_drafts.data", File.READ)
		if file_error == OK:
			var content = file.get_var()
			recipes_list = content if typeof(content) == TYPE_ARRAY else []
		file.close()
		
	recipes_list.append(new_recipe)

	var file_error: int = file.open("user://local_recipes/LOCAL_drafts.data", File.WRITE)
	if file_error == OK:
		file.store_var(recipes_list)
	else:
		push_error("ERROR SAVE") #TODO
	file.close()
	
	load_timer.start(2.0)
	yield(load_timer, "timeout")
	image_field.clear_images_files()
	form.clear()
	load_bg.set_visible(false)
	load_label.set_text("")
	set_visible(false)
		

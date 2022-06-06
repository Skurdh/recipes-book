"""
Script : NAME

"""

extends Control

# Signals

# Export variable

# Public variables
var popups_stack: Array = []

# Onready variables
onready var createrecipe_popup_pck: PackedScene = preload("res://src/interfaces/Pages/CreateRecipe.tscn")
onready var viewrecipe_popup_pck: PackedScene = preload("res://src/interfaces/Pages/ViewRecipe.tscn")
onready var myrecipes_popup_pck: PackedScene = preload("res://src/interfaces/Pages/MyRecipes.tscn")
onready var modifyrecipe_popup_pck: PackedScene = preload("res://src/interfaces/Pages/ModifyRecipe.tscn")

onready var dark_bg: ColorRect = $ColorRect2


# Setter Getter Functions

# Callback functions
func _ready():
	$Label.set_text("Bienvenue " + Profil.get_username() + " ! (#" + Profil.get_id() + ") (ALPHA v0)")
	$ColorRect/MarginContainer/Book.init()

	
# Self functions
func open_popup(pck_popup: PackedScene, data: Dictionary = {}) -> CustomPopup:
	var new_popup: CustomPopup = pck_popup.instance()
	add_child(new_popup)
	new_popup.connect("closed", self, "_on_CustomPopup_closed")
	new_popup.init(data)
	new_popup.custom_popup_centered()
	
	if popups_stack.empty():
		dark_bg.set_visible(true)
	else:
		popups_stack.back().set_visible(false)
	
	popups_stack.push_back(new_popup)
	return new_popup



# Signal functions
func _on_CustomPopup_closed() -> void:
	popups_stack.pop_back()
	if popups_stack.size() > 0:
		popups_stack.back().set_visible(true)
		popups_stack.back().refresh()
	else:
		dark_bg.set_visible(false)


#func _on_Book_recipe_pressed(recipe_id: String) -> void:
#	display_recipe_popup.populate(RecipesManager.get_recipe_from_id(recipe_id))
#	display_recipe_popup.custom_popup_centered()


func _on_MyRecipeButton_pressed():
	var new_popup: CustomPopup = open_popup(myrecipes_popup_pck)
	new_popup.connect("recipe_opened", self, "_on_recipe_opened")
	new_popup.connect("recipe_creation_request", self, "_on_AddRecipeButton_pressed")
	new_popup.connect("recipe_modify_request", self, "_on_recipe_modified")


func _on_AddRecipeButton_pressed():
	open_popup(createrecipe_popup_pck).connect("recipe_opened", self, "_on_recipe_opened")


func _on_recipe_opened(recipe_id: String) -> void:
	open_popup(viewrecipe_popup_pck, RecipesManager.get_recipe_from_id(recipe_id))


func _on_recipe_modified(recipe_id: String) -> void:
	open_popup(modifyrecipe_popup_pck, RecipesManager.get_recipe_from_id(recipe_id)).connect("recipe_opened", self, "_on_recipe_opened")


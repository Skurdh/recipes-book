"""
Script : NAME

"""
extends CustomPopup

# Signals
signal recipe_opened(recipe_id)

# Export variable

# Public variables

# Onready variables
onready var myrecipe_item: PackedScene = preload("res://src/interfaces/Items/MyRecipeItem.tscn")
onready var item_root: VBoxContainer = $Panel/MarginContainer/VBoxContainer/VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer

# Setter Getter Functions

# Callback functions

# Self functions
func init(_data: Dictionary) -> void:
	var recipes: Array = RecipesManager.get_recipes_from_author(Profil.get_id())
	
	if recipes.size() != 0:
		for recipe_data in recipes:
			var new_item: HBoxContainer = myrecipe_item.instance()
			item_root.add_child(new_item)
			item_root.add_child(HSeparator.new())
			
			new_item.populate(recipe_data)
			new_item.get_view_button().connect("pressed", self, "_on_ItemView_pressed", [recipe_data.ID])
			new_item.get_modify_button().connect("pressed", self, "_on_ItemModify_pressed", [recipe_data.ID])
			new_item.get_delete_button().connect("pressed", self, "_on_ItemDelete_pressed", [recipe_data.ID])
	else:
		$Panel/MarginContainer/VBoxContainer/VBoxContainer/Label.set_text("Vous n'avez encore publié aucune recette.")


# Signal functions
func _on_ItemView_pressed(recipe_id: String) -> void:
	emit_signal("recipe_opened", recipe_id)


func _on_ItemModify_pressed(recipe_id: String) -> void:
	print("TODO: Modify recipe : " + recipe_id)


func _on_ItemDelete_pressed(recipe_id: String) -> void:
	print("TODO: Delete recipe : " + recipe_id)

"""
Script : NAME

"""
extends CustomPopup

# Signals
signal recipe_opened(recipe_id)
signal recipe_creation_request()
signal recipe_modify_request()

# Export variable

# Public variables

# Onready variables
onready var myrecipe_item: PackedScene = preload("res://src/interfaces/Items/Recipe_MyRecipe_Item.tscn")
onready var item_root: VBoxContainer = $Panel/MarginContainer/VBoxContainer/VBoxContainer/ContainsRecipe/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
# Setter Getter Functions

# Callback functions

# Self functions
func init(_data: Dictionary) -> void:
	$Panel/MarginContainer/VBoxContainer/VBoxContainer/ContainsRecipe.set_visible(false)
	$Panel/MarginContainer/VBoxContainer/VBoxContainer/NoRecipe.set_visible(false)
	
	var recipes: Array = RecipesManager.get_recipes_from_author(Profil.get_id())
	
	if recipes.size() != 0:
		$Panel/MarginContainer/VBoxContainer/VBoxContainer/ContainsRecipe.set_visible(true)
		var i: int = 1
		for recipe_data in recipes:
			var new_item: HBoxContainer = myrecipe_item.instance()
			item_root.add_child(new_item)
			item_root.add_child(HSeparator.new())
			
			new_item.populate(i, recipe_data)
			new_item.get_view_button().connect("pressed", self, "_on_ItemView_pressed", [recipe_data.ID])
			new_item.get_modify_button().connect("pressed", self, "_on_ItemModify_pressed", [recipe_data.ID])
#			new_item.get_delete_button().connect("pressed", self, "_on_ItemDelete_pressed", [recipe_data.ID])
			i += 1
	else:
		$Panel/MarginContainer/VBoxContainer/VBoxContainer/NoRecipe.set_visible(true)

func refresh() -> void:
	clear()
	init({})


func clear() -> void:
	for child in item_root.get_children():
		child.queue_free()


# Signal functions
func _on_ItemView_pressed(recipe_id: String) -> void:
	emit_signal("recipe_opened", recipe_id)


func _on_ItemModify_pressed(recipe_id: String) -> void:
	emit_signal("recipe_modify_request", recipe_id)


func _on_ItemDelete_pressed(recipe_id: String) -> void:
	print("TODO: Delete recipe : " + recipe_id)


func _on_Publish_pressed() -> void:
	emit_signal("recipe_creation_request")

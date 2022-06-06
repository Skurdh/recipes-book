"""
Script : NAME

"""
extends HBoxContainer

# Signals
signal recipe_pressed(recipe_id)

# Export variable
export(int) var max_preview: int = 7

# Public variables
var page_index: int = 0

# Onready variables
onready var right_container: GridContainer = $Pages/Right/MarginContainer/VBoxContainer/RightContainer
onready var left_container: GridContainer = $Pages/Left/MarginContainer/VBoxContainer/LeftContainer
onready var right_label: Label = $Pages/Right/MarginContainer/VBoxContainer/RightLabel
onready var left_label: Label = $Pages/Left/MarginContainer/VBoxContainer/LeftLabel
onready var previous_button: Button = $PreviousButton
onready var next_button: Button = $NextButton

onready var recipe_preview_pck: PackedScene = preload("res://src/interfaces/Items/PreviewRecipeItem.tscn")

# Setter Getter Functions

# Callback functions


# Self functions
func init() -> void:
	update_pages()
	_disabled_button(0)
	RecipesManager.connect("request_finished", self, "_on_RecipesManager_request_finished")
	if RecipesManager.get_size() > max_preview * 2:
		_enabled_button(1)


func update_pages() -> void:
	_clear()
	var recipes: Array = RecipesManager.get_recipes_from_pos(page_index * max_preview * 2, max_preview * 2)

	for i in range(max_preview * 2):
		if i >= recipes.size(): break
		
		var preview: HBoxContainer = recipe_preview_pck.instance()
		var h_separator: HSeparator = HSeparator.new()
		if i < max_preview:
			left_container.add_child(preview)
			left_container.add_child(h_separator)
		else:
			right_container.add_child(preview)
			right_container.add_child(h_separator)

		preview.populate(recipes[i])
		preview.get_button().connect("pressed", self, "_on_Preview_pressed", [recipes[i].ID])
		
		

	left_label.set_text("- " + String(page_index + page_index + 1) + " -")
	right_label.set_text("- " + String(page_index + page_index + 2) + " -")


func next_page() -> void:
	var recipes_count: int = RecipesManager.get_size()
	var preview_count: int = (page_index + 1) * max_preview * 2
	if preview_count < recipes_count:
		page_index += 1
		update_pages()
		print(preview_count + max_preview * 2, " >= ", recipes_count)
		if preview_count + max_preview * 2 >= recipes_count:
			_disabled_button(1)
		if previous_button.is_disabled():
			_enabled_button(0)


func previous_page() -> void:
	if page_index - 1 >= 0:
		page_index -= 1
		update_pages()
		if page_index == 0:
			_disabled_button(0)
		if next_button.is_disabled():
			_enabled_button(1)


func _disabled_button(idx: int) -> void:
	var button: Button = previous_button if idx == 0 else next_button
	button.set_disabled(true)
	button.get_node("CenterContainer/TextureRect").set_modulate(Color(0.521569, 0.52549, 0.54902))


func _enabled_button(idx: int) -> void:
	var button: Button = previous_button if idx == 0 else next_button
	button.set_disabled(false)
	button.get_node("CenterContainer/TextureRect").set_modulate(Color(0.901961, 0.905882, 0.92549))


func _clear() -> void:
	for i in range(left_container.get_child_count()):
		left_container.get_child(i).queue_free()
		
	for i in range(right_container.get_child_count()):
		right_container.get_child(i).queue_free()



# Signal functions
func _on_PreviousButton_pressed():
	previous_page()


func _on_NextButton_pressed():
	next_page()


func _on_Preview_pressed(recipe_id: String) -> void:
	emit_signal("recipe_pressed", recipe_id)


func _on_RecipesManager_request_finished(infos: Dictionary) -> void:
	if (infos.request_return == "add" or infos.request_return == "update") and infos.content == 0:
		update_pages()

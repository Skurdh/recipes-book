"""
Script : NAME

"""

extends CustomPopup

# Signals
signal recipe_opened(id)
# Export variable

# Public variables
const _ingredient_item_document: Dictionary = {"ingredient":"", "quantity":"", "unit":"", "add":"", "link_r":"", "pressed":""}

var edited_item: MarginContainer
var generated_color: Dictionary = {}
var recipes_id: Array = []

# Onready variables
onready var ingredient_item_pck: PackedScene = preload("res://src/interfaces/Items/Ingredient_CreateShoppingList_Item.tscn")
onready var recipe_item_pck: PackedScene = preload("res://src/interfaces/Items/Recipe_CreateShoppingList_Item.tscn")
onready var ingredient_list_root: VBoxContainer = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/IngredientsListField
onready var edit_popup: Popup = $EditIngredientPopup
onready var color_rect: ColorRect = $ColorRect
onready var edit_form: Form = $EditIngredientPopup/EditForm
onready var list_form: Form = $ListForm





# Setter Getter Functions

# Callback functions
func _ready() -> void:
	custom_popup_centered()
	
	load_indexes()
	populate({"ingredients":[{"quantity": 200, "unit":"gr", "ingredient":"Poivrot", "link_r":"#dsjkdhsqkjdhqs"}], "recipes":[{"title": "Coucou", "id":"#dsjkdhsqkjdhqs"}, {"title": "Recette", "id":"qsqs544478"}]})
	
# Self functions
func load_indexes() -> void:
	var file: File = File.new()
	var file_error: int = file.open("user://LOCAL_indexes.data", File.READ)
	if file_error == OK:
		var indexes: Dictionary = file.get_var()
		
		$Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/IngredientForm/VBoxContainer/HBoxContainer/UnitField.index = indexes.units
		$Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/IngredientForm/VBoxContainer/HBoxContainer/UnitField.set_editable(true)
		$Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/IngredientForm/VBoxContainer/HBoxContainer/IngredientField.index = indexes.ingredients
		$Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/IngredientForm/VBoxContainer/HBoxContainer/IngredientField.set_editable(true)
		edit_popup.get_node("Panel/MarginContainer/VBoxContainer/IngredientField").index = indexes.ingredients
		edit_popup.get_node("Panel/MarginContainer/VBoxContainer/IngredientField").set_editable(true)
		edit_popup.get_node("Panel/MarginContainer/VBoxContainer/IngredientField2").index = indexes.units
		edit_popup.get_node("Panel/MarginContainer/VBoxContainer/IngredientField2").set_editable(true)
		file.close()
	else:
		push_error("ERROR FILE.") #TODO


func unload_indexes() -> void:
	$Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/IngredientForm/VBoxContainer/HBoxContainer/UnitField.index.clear()
	$Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/IngredientForm/VBoxContainer/HBoxContainer/IngredientField.index.clear()


func populate(data: Dictionary) -> void: #INPUT
	var edit_select_field: VBoxContainer = $EditIngredientPopup/Panel/MarginContainer/VBoxContainer/SelectField
	var ing_select_field: VBoxContainer = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/IngredientForm/VBoxContainer/HBoxContainer2/SelectField
	var form_data: Dictionary = {"ingredients":[], "recipes":[]}
	generated_color.clear()

	for recipe in data.recipes:
		var new_item: MarginContainer = recipe_item_pck.instance()
		generated_color[recipe.id] = generate_color()
		recipes_id.append(recipe.id)
		new_item.populate(recipe, generated_color[recipe.id])
		new_item.get_view_button().connect("pressed", self, "_on_ItemView_pressed", [recipe.id])
		form_data.recipes.append(new_item)
		ing_select_field.add_option(recipe.title)
		edit_select_field.add_option(recipe.title)
	
	for ingredient in data.ingredients:
		var new_item: MarginContainer = ingredient_item_pck.instance()
		new_item.populate(ingredient, generated_color[ingredient.link_r] if generated_color.has(ingredient.link_r) else Color(0.878431, 0.878431, 0.878431))
		new_item.get_edit_button().connect("pressed", self, "_on_IngredientItem_edit_pressed", [new_item])
		new_item.connect("deleted", self, "_on_IngredientItem_deleted")
		form_data.ingredients.append(new_item)
	
	
	
	list_form.inject_data(form_data)





func generate_color() -> Color:
	return Color.from_hsv(rand_range(0.0, 1.0), 0.55, 0.92, 1.0)


func convert_idx_to_id(idx: int) -> String:
	return recipes_id[idx-1] if idx-1 < recipes_id.size() and idx-1 >= 0 else "" 


func convert_id_to_idx(id: String) -> int:
	var find: int = recipes_id.find(id)
	return find+1 if find != -1 else 0


# Signal functions
func _on_AddIngredientForm_data_collected(data: Array) -> void:
	var ingredient_data: Dictionary = {}
	for entry in data:
		if entry.id == "link_r":
			ingredient_data[entry.id] = convert_idx_to_id(entry.content)
		else: 
			ingredient_data[entry.id] = entry.content 
	
	if not ingredient_data.empty():
		var new_item: MarginContainer = ingredient_item_pck.instance()
		ingredient_list_root.add_item(new_item)
		new_item.populate(ingredient_data, generated_color[ingredient_data.link_r] if generated_color.has(ingredient_data.link_r) else Color(0.878431, 0.878431, 0.878431))
		new_item.get_edit_button().connect("pressed", self, "_on_IngredientItem_edit_pressed", [new_item])
		new_item.connect("deleted", self, "_on_IngredientItem_deleted")


func _on_IngredientItem_edit_pressed(item: MarginContainer) -> void:
	edited_item = item
	var d_data: Dictionary = _ingredient_item_document.duplicate()
	for key in item.data.keys():
		if d_data.has(key):
			if key == "link_r":
				d_data[key] = convert_id_to_idx(item.data[key])
			else:
				d_data[key] = item.data[key]
	edit_form.inject_data(d_data)
	edit_popup.popup_centered()
	color_rect.set_visible(true)


func _on_IngredientItem_deleted() -> void:
	pass


func _on_EditForm_data_collected(data: Array) -> void:
	var ingredient_data: Dictionary = {}
	for entry in data:
		if entry.id == "link_r":
			ingredient_data[entry.id] = convert_idx_to_id(entry.content)
		else:
			ingredient_data[entry.id] = entry.content
		
	
	if not ingredient_data.empty():
		edited_item.populate(ingredient_data, generated_color[ingredient_data.link_r] if generated_color.has(ingredient_data.link_r) else Color(0.878431, 0.878431, 0.878431))
		ingredient_list_root._on_FieldControl_focus_exited()
	edited_item = null
	_on_EditForm_form_aborted()


func _on_EditForm_form_aborted() -> void:
	edit_popup.set_visible(false)
	color_rect.set_visible(false)


func _on_ListForm_data_collected(data: Array) -> void:
	print(data)


func _on_ListForm_form_aborted() -> void:
	_on_Close_pressed()


func _on_ItemView_pressed(recipe_id: String) -> void:
	print(recipe_id)
	emit_signal("recipe_opened", recipe_id)

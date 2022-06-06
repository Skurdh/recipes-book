"""
Script : NAME

"""

extends CustomPopup

# Signals

# Export variable

# Public variables

# Onready variables
onready var ingredient_item_pck: PackedScene = preload("res://src/interfaces/Items/Ingredient_ViewRecipe_Item.tscn")
onready var instruction_item_pck: PackedScene = preload("res://src/interfaces/Items/Instruction_ViewRecipe_Item.tscn")


# Setter Getter Functions

# Callback functions

# Self functions
func init(data: Dictionary) -> void:
	if not data.empty():
		$Panel/MarginContainer/VBoxContainer/TopBar/Label.set_text("Recette : " + data.title)
		
		# Title
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/HBoxContainer/Title").set_text(data.title)
		# Author
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Author").set_text(data.author)
		# Category
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Category").populate({"name": RecipesManager.R_CATEGORY[data.category-1]})
		
		# Season
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/SeasonInfoItem").populate(data.season)
		
		# Diet
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Diet").populate({"name": RecipesManager.R_DIET[data.diet-1], "idx": data.diet-1})

		#PrepartionTime
		var prep_time_formated: String = RecipesManager.tools_string_time_format(data.prep_time)
		if prep_time_formated != "":
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/PrepTime").populate({"name": prep_time_formated})
		else:
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/PrepTime").set_visible(false)
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/VSeparator5").set_visible(false)
		
		#CookTime
		var cook_time_formated: String = RecipesManager.tools_string_time_format(data.cook_time)
		if cook_time_formated != "":	
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/CookTime").populate({"name": cook_time_formated})
		else:
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/CookTime").set_visible(false)
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/VSeparator6").set_visible(false)
	
		#Quality
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Quality").populate({"name": RecipesManager.R_QUALITY[data.quality-1], "idx": data.quality-1})
	
		# Portions
		get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/LineEdit").set_text(String(data.portions))
		
		# Ingredients
		var ingredients_root:  VBoxContainer = get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/IngredientsRoot")
		for ingredient_data in data.ingredients:
			var new_item: MarginContainer = ingredient_item_pck.instance()
			ingredients_root.add_child(new_item)
			new_item.populate(ingredient_data)
			ingredients_root.add_child(HSeparator.new())
		
		# Instructions
		var instructions_root: VBoxContainer = get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Instructions/InstructionsRoot")
		var instructions_string: String = ""
		for idx in data.instructions.size():
			var new_item: PanelContainer = instruction_item_pck.instance()
			instructions_root.add_child(new_item)
			new_item.populate(idx, data.instructions[idx])
		
		# Notes
		if not data.notes[0].empty():
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Note").set_visible(true)
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Note/PanelContainer/Label").set_text(data.notes[0])
		
		if data.has("gluten_free") and data.gluten_free:
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/GlutenFree").set_visible(true)		
		if data.has("milk_free") and data.milk_free:
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/MilkFree").set_visible(true)
		if data.has("with_sugar") and data.with_sugar:
			get_node("Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/WithSugar").set_visible(true)
	
		# Modify Button
		if data.author_id == Profil.get_id():
			$Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/HBoxContainer/Modify.set_visible(true)
			$Panel/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Content/MarginContainer/VBoxContainer/HBoxContainer/Modify.connect("pressed", self, "_on_Modify_pressed", [data.ID])
	else:
		push_error("DISPLAY RECIPE VOID") #TODO




# Signal functions
func _on_Modify_pressed(recipe_id: String) -> void:
	print(recipe_id)

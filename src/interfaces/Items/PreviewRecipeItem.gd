"""
Script : NAME

"""

extends HBoxContainer

# Signals

# Export variable

# Public variables

# Onready variables


# Setter Getter Functions

# Callback functions

# Self functions
func populate(data: Dictionary) -> void:
	# Title
	get_node("Button/MarginContainer/VBoxContainer/Label").set_text(data.title)
	# Category
	get_node("Button/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer2/PanelContainer/Category").set_text(RecipesManager.R_CATEGORY[data.category-1])
	# Portions-
	get_node("Button/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer2/Portions").populate({"name": String(data.portions)})
	# PrepTime
	get_node("Button/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer2/PrepTime").populate({"name":RecipesManager.tools_string_time_format(data.prep_time, true)})
	# CookTime
	get_node("Button/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer2/CookTime").populate({"name":RecipesManager.tools_string_time_format(data.cook_time, true)})
	# Seasons
	get_node("Button/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer3/SeasonInfoItem").populate(data.season)
	# Diet
	get_node("Button/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer3/Diet").populate({"name": RecipesManager.R_DIET[data.diet-1], "idx": data.diet-1})
	# Quality
	get_node("Button/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer3/Quality").populate({"name": RecipesManager.R_QUALITY[data.quality-1], "idx": data.quality-1})
	# Milk, Sugar, Gluten
	var label_root: HBoxContainer = get_node("Button/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer2/LabelRoot")
	if data.milk_free:
		label_root.get_child(2).set_visible(true)
	if data.gluten_free:
		label_root.get_child(1).set_visible(true)
	if data.with_sugar:
		label_root.get_child(0).set_visible(true)


func get_button() -> Button:
	var button: Button = $Button
	return button


# Signal functions

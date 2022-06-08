"""
Script : NAME

"""

extends CustomPopup

# Signals
signal recipe_opened()

# Export variable

# Public variables
var recipe_id: String = ""
# Onready variables


# Setter Getter Functions

# Callback functions

# Self functions
func init(recipe_data: Dictionary) -> void:
	$Panel/MarginContainer/VBoxContainer/TopBar/Label.set_text("Modifier ma recette : " + recipe_data.title)
	recipe_id = recipe_data.ID
	$Form.inject_data(recipe_data)


# Signal functions
func _on_Form_data_collected(data: Array):
	RecipesManager.update_recipe_doc(recipe_id, data)
	var infos: Dictionary = yield(RecipesManager, "request_finished")
	if infos.request_return == "update" and infos.content == 0:
		emit_signal("recipe_opened", infos.extra)
		_on_Close_pressed()


func _on_Form_form_aborted() -> void:
	_on_Close_pressed()

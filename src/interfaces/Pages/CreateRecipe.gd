"""
Script : NAME

"""
extends CustomPopup

# Signals
signal recipe_opened(recipe_id)

# Export variable

# Public variables
var form_complee
# Onready variables


# Setter Getter Functions

# Callback functions
func _ready():
	custom_popup_centered()

# Self functions

# Signal functions
func _on_Form_data_collected(data: Array):
	RecipesManager.add_recipe_doc(data)
	var infos: Dictionary = yield(RecipesManager, "request_finished")
	if infos.request_return == "add" and infos.content == 0:
		emit_signal("recipe_opened", infos.extra)
		_on_Close_pressed()

"""
Script : NAME

"""

extends Control

# Signals
signal deleted()

# Export variable

# Public variables
const vowels: Array = ["h", "a", "é", "e", "o", "u", "y", "i"]
var data: Dictionary = {}

# Onready variables

# Setter Getter Functions

# Callback functions
func _ready():
	connect("tree_exited", self, "_on_tree_exited")



# Self functions
func populate(new_data: Dictionary) -> void:	
	data = new_data.duplicate()
	
	if data.has("unit"):
		$QuantityLabel.set_text(String(data.quantity) + " " + data.unit)
		$PrepLabel.set_visible(true)
		$PrepLabel.set_text(get_elide(data.ingredient))
	else:
		if data["quantity"] == 0:
			$QuantityLabel.set_visible(false)
		else:
			$QuantityLabel.set_text(String(data.quantity))
	
	$IngredientLabel.set_text(data.ingredient if data["quantity"] != 0 else data.ingredient[0].to_upper() + data.ingredient.substr(1, -1))
	if data.has("additional"):
		$AdditionalLabel.set_text(data.additional)


func get_elide(ingredient: String) -> String:
	if vowels.find(ingredient.substr(0, 1)) != -1:
		return "d'"
	return "de"

	
# Signal functions
func _on_Delete_pressed() -> void:
	queue_free()


func _on_tree_exited() -> void:
	emit_signal("deleted")

"""
Script : NAME

"""

extends HBoxContainer

# Signals

# Export variable
export(bool) var compressed: bool = false

# Public variables

# Onready variables
onready var month_selected_pck: PackedScene = preload("res://src/interfaces/Items/MonthSeasonSelected_Item.tscn")
onready var month_unselected_pck: PackedScene = preload("res://src/interfaces/Items/MonthSeasonUnselected_Item.tscn")


# Setter Getter Functions

# Callback functions

# Self functions
func populate(data: String) -> void:
	var months_root: HBoxContainer = $MonthsRoot
	var month_data: String = data if data.length() == 12 else "111111111111"
	
	if compressed:
		months_root.set("custom_constants/separation", 0)

	var i: int = 0
	for state in month_data:
		var new_item: Label = month_unselected_pck.instance() if int(state) == 0 else month_selected_pck.instance()
		new_item.set_text(RecipesManager.R_MONTH[i])
		months_root.add_child(new_item)
		i += 1

# Signal functions

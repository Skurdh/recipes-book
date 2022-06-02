"""
Script : NAME

"""

extends Control

# Signals

# Export variable

# Public variables
var table: Array = []

# Onready variables


# Setter Getter Functions

# Callback functions

func arr_join(arr, separator = ""):
	var output = "";
	for s in arr:
		output += '"' + str(s) + '"' + separator
	output = output.left( output.length() - separator.length() )
	return output

# Self functions

# Signal functions
func _on_Button_pressed() -> void:
	var text: String = $VBoxContainer/HBoxContainer/LineEdit.get_text()
	
	if table.find(text) == -1:
		var t = []
		t.append(text)
		t.append($VBoxContainer/HBoxContainer/LineEdit2.get_text())
		table.append(t)
		$VBoxContainer/ItemList.add_item(text)
	
	$VBoxContainer/HBoxContainer/LineEdit.grab_focus()
	$VBoxContainer/HBoxContainer/LineEdit.set_text("")
	$VBoxContainer/HBoxContainer/LineEdit2.set_text("")


func _on_Button2_pressed() -> void:
	print(table)

"""
Script : NAME

"""
tool
extends ComplexField

# Signals

# Export variable
export(String) var placeholder_label: String = ""
export(bool) var only_suggestion: bool = false
export(bool) var approximate: bool = false
export(int) var limit: int = 10


# Public variables
var selected_idx: int = -1
var index: Dictionary = {}
var has_error: bool = false

# Onready variables
onready var line_edit: LineEdit = $HBoxContainer2/LineEdit
onready var suggestions_popup: PopupPanel = $HBoxContainer2/LineEdit/PopupPanel
onready var item_list: ItemList = $HBoxContainer2/LineEdit/PopupPanel/ItemList

onready var error_stylebox: StyleBoxFlat = preload("res://assets/themes/AutoCompletion_Error_StyleBox.tres")

# Setter Getter Functions

# Callback functions
func _ready() -> void:
# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", self, "_on_Viewport_size_changed")
	line_edit.set_placeholder(placeholder_label)
	
	
# Self functions
func set_editable(value: bool) -> void:
	line_edit.set_editable(value)
	

func get_popup_position() -> Rect2:
	var size_y: float = item_list.get_item_count() * 36 + 16
	return Rect2(get_global_position() - Vector2(0, size_y), Vector2(get_size().x, size_y))


func close_popup() -> void:
	selected_idx = -1
	item_list.clear()
	suggestions_popup.set_visible(false)


func get_suggestions(new_text: String) -> Array:
	if new_text == "": return []
	
	var suggestions: Array = []
	var text: String = new_text.to_lower()
	
	for i in range(index.items.size()):
		var item: String = index.items[i].to_lower()
		if (approximate and text in item) or (not approximate and item.begins_with(text)):
			
			if index.abbreviations.has(String(i)):
				suggestions.append([item, index.abbreviations[String(i)]])
			else:
				suggestions.append([item, ""])
				
			if limit != 0 and suggestions.size() >= limit:
				break

	return suggestions


func select_suggestion() -> void:
	var metadata: String = item_list.get_item_metadata(selected_idx)
	line_edit.set_text(metadata)
	line_edit.set_cursor_position(line_edit.get_text().length())
	
	
func check_text_entered() -> void:
	var text: String = line_edit.get_text()
	if not text == "" and only_suggestion:
		if index.items.find(text) != -1 or check_abbreviations(text):
			return
		
		print_error("Entrée invalide !")


func check_abbreviations(text: String) -> bool:
	for abb in index.abbreviations.values():
		if text == abb:
			return true
	
	return false


func set_data(value: String) -> void:
	print("TODO SET DATA SUGGESTION INPUT FIELD")
	pass


func get_data() -> String:
	return line_edit.get_text()


func clear_field() -> void:
	.clear_field()
	line_edit.set_text("")


func push_field_error() -> void:
	print_error(errors_list[0])


func is_empty() -> bool:
	if line_edit.get_text().empty() and is_required:
		return true
	return false


func print_error(text: String) -> void:
	line_edit.set_text("")
	line_edit.set_placeholder(text)
	line_edit.set("custom_styles/normal", error_stylebox)




# Signal functions	
func _on_LineEdit_text_changed(new_text: String) -> void:
	close_popup()
	if index.empty(): return
	
	var suggestions: Array = get_suggestions(new_text)
	
	if not suggestions.empty():
		for suggestion in suggestions:
			var idx: int = item_list.get_item_count()
			item_list.add_item(suggestion[0])
			item_list.set_item_metadata(idx, suggestion[1] if not suggestion[1].empty() else suggestion[0])

		selected_idx = item_list.get_item_count()
		suggestions_popup.popup(get_popup_position())


func _on_LineEdit_focus_entered() -> void:
	line_edit.set_placeholder(placeholder_label)
	line_edit.set("custom_styles/normal", null)


func _on_LineEdit_focus_exited() -> void:
	close_popup()
	check_text_entered()


func _on_LineEdit_gui_input(event: InputEvent) -> void:
	if suggestions_popup.is_visible() and get_focus_owner() == self and event is InputEventKey:
		if event.is_pressed():
			if event.get_scancode() == 16777232:
# warning-ignore:narrowing_conversion
				selected_idx = max(0, selected_idx - 1)
				item_list.select(selected_idx)
				select_suggestion()
			elif event.get_scancode() == 16777234:
# warning-ignore:narrowing_conversion
				selected_idx = min(selected_idx + 1, item_list.get_item_count() - 1)
				item_list.select(selected_idx)
				select_suggestion()
			elif event.get_scancode() == 16777221:
				close_popup()


func _on_ItemList_item_selected(idx: int) -> void:
	selected_idx = idx
	select_suggestion()
	close_popup()


func _on_Viewport_size_changed() -> void:
	if suggestions_popup.is_visible():
		yield(get_tree(), "idle_frame")
		suggestions_popup.popup(get_popup_position())

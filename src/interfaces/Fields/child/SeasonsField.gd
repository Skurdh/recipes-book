"""
Script : NAME

"""

extends ComplexField

# Signals

# Export variable

# Public variables
const SEASONS: Array = ["Toute Saison", "Printemps", "Mars", "Avril", "Mai", "Été", "Juin", "Juillet", "Août", "Automne", "Septembre", "Octobre", "Novembre", "Hiver", "Décembre", "Janvier", "Février"]
var selected_button: Button

# Onready variables
onready var select_button: Button = $HBoxContainer2/SelectButton
onready var popup_panel: PopupPanel = $HBoxContainer2/SelectButton/PopupPanel

# Setter Getter Functions

# Callback functions
func _ready() -> void:
# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", self, "_on_Viewport_size_changed")
	for node in get_tree().get_nodes_in_group("season_button"):
		node.connect("pressed", self, "_on_Button_pressed", [node])


# Self functions
func get_popup_rect() -> Rect2:
	var button_global_rect: Rect2 = select_button.get_global_rect()
	
	return Rect2(button_global_rect.position + Vector2(0, 36), Vector2(button_global_rect.size.x, 432))


func set_data(season: int) -> void:
	var button: Button = find_node(String(season))
	if button != null:
		selected_button = button
		button.set_pressed(true)
		select_button.text = SEASONS[season]


func get_data() -> int:
	return int(selected_button.name)
	
	
func is_empty() -> bool:
	if select_button.get_text() == "- Sélectionner -" or selected_button == null:
		return true
	return false


func push_field_error() -> void:
	print_error(errors_list[0])


func clear_field() -> void:
	.clear_field()
	select_button.set_text("- Sélectionner -")
	if selected_button != null:
		selected_button.set_pressed(false)
	selected_button = null


# Signal functions
func _on_SelectButton_pressed() -> void:
	if select_button.is_pressed():
		popup_panel.popup(get_popup_rect())


func _on_Button_pressed(button: Button) -> void:
	if selected_button != null:
		selected_button.set_pressed(false)
	
	selected_button = button
	select_button.set_text(SEASONS[int(button.name)])
	popup_panel.set_visible(false)


func _on_Viewport_size_changed() -> void:
	if popup_panel.is_visible():
		yield(get_tree(), "idle_frame")
		popup_panel.popup(get_popup_rect())


func _on_SelectButton_focus_exited() -> void:
	popup_panel.set_visible(false)
	select_button.set_pressed(false)


func _on_PopupPanel_popup_hide() -> void:
	select_button.set_pressed(false)

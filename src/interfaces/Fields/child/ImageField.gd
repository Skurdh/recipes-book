"""
Script : NAME

"""

extends ComplexField

# Signals

# Export variable
export(String) var image_name: String = "recipe_image"
export(String) var batch_name: String = "launch_convert.bat"

# Public variables
const uuid_util = preload('res://src/ressources/uuid.gd')

# Onready variables
onready var file_popup: FileDialog = $FileDialog
#onready var zoom_image: CustomPopup = $ZoomImage
onready var dialog_label: Label = file_popup.get_label()
onready var panel: Panel = $HBoxContainer2/Panel/Panel3
onready var texture_rect: TextureRect = $HBoxContainer2/Panel/Panel3/MarginContainer/TextureRect

# Setter Getter Functions

# Callback functions
func _ready() -> void:
# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", self, "_on_Viewport_size_changed")
	file_popup.set_current_dir(OS.get_system_dir(3))
	dialog_label.set("custom_colors/font_color", Color(0.737255, 0.203922, 0.203922))
	dialog_label.set("custom_fonts/font", preload("res://assets/fonts/PT-Bold_14.tres"))


# Self functions
func resize_image(image: Image) -> void:
	var img_size: Vector2 = image.get_size()
	if img_size.x <= 1599 and img_size.y <= 1599:
		return
	
	if img_size.x > img_size.y:
# warning-ignore:narrowing_conversion
		var resized_y: int = 1599 * img_size.y / img_size.x
		image.resize(1599, resized_y, 2)
	else:
# warning-ignore:narrowing_conversion
		var resized_x: int = 1599 * img_size.x / img_size.y
		image.resize(resized_x, 1599, 2)
	
	
func clear_images_files() -> void:
	var dir: Directory = Directory.new()
	dir.remove("user://converter/" + image_name + ".png")
	dir.remove("user://converter/output/" + image_name + ".jpg")
	texture_rect.set_texture(null)
	

func print_popup_error(error_text: String) -> void:
	file_popup.set_text(error_text)
	var popup_rect: Rect2 = file_popup.get_global_rect()
	yield(get_tree(), "idle_frame")
	file_popup.popup(popup_rect)


func set_data(value) -> void:
	push_error("A FAIRE !! RECUPERER UNE IMAGE !!")


func get_data():
	return  [uuid_util.v4(), texture_rect.get_texture().get_data()]
	push_error("A FAIRE !! envoyer UNE IMAGE !!")


func push_field_error() -> void:
	print_error(errors_list[0])


func is_empty() -> bool:
	return texture_rect.get_texture() == null


func clear_field() -> void:
	.clear_field()
	panel.set_visible(false)


# Signal functions
func _on_AddImage_pressed() -> void:
	file_popup.popup_centered_ratio(0.65)


func _on_Viewport_size_changed() -> void:
	if file_popup.is_visible():
		yield(get_tree(), "idle_frame")
		file_popup.popup_centered_ratio(0.65)


func _on_FileDialog_file_selected(path: String) -> void:
	var image: Image = Image.new()
	if image.load(path) == OK:
		resize_image(image)
		var texture: Texture = ImageTexture.new()
		texture.create_from_image(image)
		texture_rect.set_texture(texture)
		panel.set_visible(true)	
	else:
		print_popup_error("Le format du fichier n'est pas prise en charge.")


func _on_Trash_pressed() -> void:
	panel.set_visible(false)
	texture_rect.set_texture(null)
	clear_images_files()


#func _on_Zoom_pressed() -> void:
#	zoom_image.set_image(texture_rect.get_texture())
#	zoom_image.custom_popup_centered()


#
#func _on_Button_pressed() -> void:
#	Firebase.Auth.login_with_email_and_password("vinegraphe@gmail.com", "jormun")
#	yield(get_tree().create_timer(2.0), "timeout")
#
#	var c = get_field_data()
#
#	var uuid = uuid_util.v4()
#	var t = Firebase.Storage.ref("recipe_images/upload/" + uuid + ".jpg").put_file(c[1])
#	yield(t, "task_finished")

"""
Script : NAME

"""

extends PanelContainer

# Signals
signal succeeded()

# Export variable

# Public variables
var sign_in_infos: Array = []
var auto_auth: bool = false

# Onready variables
onready var email_line_edit: LineEdit = $MarginContainer/VBoxContainer/EmailLineEdit
onready var password_line_edit: LineEdit = $MarginContainer/VBoxContainer/PasswordLineEdit

onready var email_error: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Error
onready var password_error: Label = $MarginContainer/VBoxContainer/HBoxContainer3/Error


# Setter Getter Functions

# Callback functions
func _ready() -> void:
# warning-ignore:return_value_discarded
	Firebase.Auth.connect("login_succeeded", self, "_on_Auth_login_succeeded")
# warning-ignore:return_value_discarded
	Firebase.Auth.connect("login_failed", self, "_on_Auth_login_failed")
	
	if load_auth():
		auto_auth = true
		Firebase.Auth.login_with_email_and_password(sign_in_infos[0], sign_in_infos[1])


# Self functions
func check_content(email_check: bool = true, password_check: bool = true) -> bool:
	var error: bool = false
	# Clear error labels
	email_error.text = ""
	password_error.text = ""
	
	if email_check and email_line_edit.text.empty():
		email_error.text = "Ce champ est requis."
		error = true
	if password_check and password_line_edit.text.empty():
		password_error.text = "Ce champ est requis."
		error = true
	
	return error


func get_create_account_button() -> Node:
	return $MarginContainer/VBoxContainer/HBoxContainer/CreateAccount


func save_auth() -> void:
	if not sign_in_infos.empty():
		var file: File = File.new()
		file.open_encrypted_with_pass("user://user.auth", File.WRITE, "1wy9&BmZ$%9&UhJRP#b816LqDzwbrkkF")
		file.store_var(sign_in_infos)
		file.close()


func load_auth() -> bool:
	var file: File = File.new()
	if file.open_encrypted_with_pass("user://user.auth", File.READ, "1wy9&BmZ$%9&UhJRP#b816LqDzwbrkkF") == OK:
		sign_in_infos = file.get_var()
		return true
		
	file.close()
	return false


	
# Signal functions
func _on_SignIn_pressed() -> void:
	if not check_content():
		sign_in_infos.append(email_line_edit.text)
		sign_in_infos.append(password_line_edit.text)
		Firebase.Auth.login_with_email_and_password(email_line_edit.text, password_line_edit.text)


func _on_ForgetPassword_pressed() -> void:
	if not check_content(true, false):
		Firebase.Auth.send_password_reset_email(email_line_edit.text)
	
	
func _on_Auth_login_succeeded(_auth_infos: Dictionary) -> void:
	if not auto_auth:
		save_auth()
	emit_signal("succeeded")


func _on_Auth_login_failed(_code, message: String) -> void:
	sign_in_infos.clear()
	match message:
		"INVALID_EMAIL":
			email_error.text = "L'email est invalide."
		"EMAIL_NOT_FOUND":
			email_error.text = "L'email n'existe pas."
		"INVALID_PASSWORD":
			password_error.text = "Le mot de passe est invalide."
		"USER_DISABLED":
			email_error.text = "Le compte est désactivé."

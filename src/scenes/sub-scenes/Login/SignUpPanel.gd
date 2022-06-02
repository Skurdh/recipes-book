"""
Script : NAME

"""

extends PanelContainer

# Signals
signal succeeded()

# Export variable

# Public variables
const _new_user_document_body: Dictionary = {
	"email": "",
	"username": "",
#	"has_access": false,
#	"accesskey": "",
	"parameters": []
}

#const _new_accesskey_document_body: Dictionary = {
#	"owner": "",
#	"invitees": [],
#}

var user_entries: Dictionary = {
	"email": "",
	"username": ""
}

# Onready variables
onready var email_line_edit: LineEdit = $MarginContainer/VBoxContainer/EmailLineEdit
onready var password_line_edit: LineEdit = $MarginContainer/VBoxContainer/PasswordLineEdit
onready var username_line_edit: LineEdit = $MarginContainer/VBoxContainer/UsernameLineEdit

onready var email_error: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Error
onready var password_error: Label = $MarginContainer/VBoxContainer/HBoxContainer3/Error
onready var username_error: Label = $MarginContainer/VBoxContainer/HBoxContainer4/Error


# Setter Getter Functions

# Callback functions
func _ready() -> void:
# warning-ignore:return_value_discarded
	Firebase.Auth.connect("signup_succeeded", self, "_on_Auth_signup_succeeded")
# warning-ignore:return_value_discarded
	Firebase.Auth.connect("signup_failed", self, "_on_Auth_signup_failed")


# Self functions
func check_content() -> bool:
	var error: bool = false
	# Clear error labels
	email_error.text = ""
	password_error.text = ""
	username_error.text = ""
	
	if email_line_edit.text.empty():
		email_error.text = "Ce champ est requis."
		error = true
	if username_line_edit.text.empty():
		username_error.text = "Ce champ est requis."
		error = true
	if password_line_edit.text.empty():
		password_error.text = "Ce champ est requis."
		error = true
	
	return error


#func generate_accesskey() -> String:
#	# Open AccessKey Words
#	var accesskey_file: File = File.new()
#	accesskey_file.open("res://src/ressources/AccessKeyWords.json", File.READ)
#	var words: Dictionary = parse_json(accesskey_file.get_as_text())
#
##	# Get the AccessKey list
#	var query: FirestoreQuery = FirestoreQuery.new().from("accesskeys", false)
#	var accesskeys_task = yield(Firebase.Firestore.query(query), "result_query")
#	var existing_accesskeys: Array = []
#	for accesskey in accesskeys_task:
#		existing_accesskeys.append(accesskey.doc_name)
#
#	var count_secure: int = 0
#	while true or count_secure >= 100:
#		var new_accesskey: String = words.fruits[randi() % words.fruits.size()] + words.adjectives[randi() % words.adjectives.size()]
#		if existing_accesskeys.find(new_accesskey) == -1:
#			return new_accesskey
#		count_secure += 1
#
#	return "error-accesskey"
			

func get_sign_in_button() -> Node:
	return $MarginContainer/VBoxContainer/HBoxContainer/SignIn
	

# Signal functions
func _on_Continue_pressed() -> void:
	if not check_content():
		user_entries.email = email_line_edit.text
		user_entries.username = username_line_edit.text
		Firebase.Auth.signup_with_email_and_password(email_line_edit.text, password_line_edit.text)
	
	
func _on_Auth_signup_succeeded(auth_infos: Dictionary) -> void:
	# Create new user document
	var new_user: Dictionary = _new_user_document_body.duplicate()
	for key in user_entries.keys():
		new_user[key] = user_entries[key]
#	new_user.accesskey = yield(generate_accesskey(), "completed")
	
	# Add document to collection
	var users_collection: FirestoreCollection = Firebase.Firestore.collection("users")
	yield(users_collection.add(auth_infos.localid, new_user), "task_finished")
	
	Firebase.Auth.save_auth(auth_infos)
	emit_signal("succeeded")


func _on_Auth_signup_failed(_code, message: String) -> void:
	match message:
		"INVALID_EMAIL":
			email_error.text = "L'email est invalide."
		"EMAIL_NOT_FOUND":
			email_error.text = "L'email n'existe pas."
		"INVALID_PASSWORD":
			password_error.text = "Le mot de passe est invalide."
		"USER_DISABLED":
			email_error.text = "Le compte est désactivé."
		"WEAK_PASSWORD":
			password_error.text = "Le mot de passe est trop faible (6 caractères minimum)."

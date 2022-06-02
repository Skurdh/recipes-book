"""
Script : NAME

"""

extends Control

# Signals

# Export variable

# Public variables
var _temp_input_infos: Dictionary = {} # formulaires contiendront les infos.

#####
var _new_user_document_body: Dictionary = {
	"email": "",
	"username": "",
	"has_access": false,
	"accesskey": "",
	"invitees": [],
	"parameters": []
}

var _new_acceskey_document_body: Dictionary = {
	"owner": "",
	"followers": []
}

# Onready variables
onready var popup_accesskey: Popup = $PopupAccessKey

# Setter Getter Functions

# Callback functions
func _ready() -> void:
	Firebase.Auth.connect("login_succeeded", self, "_on_Auth_login_succeeded")
	Firebase.Auth.connect("login_failed", self, "_on_Auth_login_failed")
	Firebase.Auth.connect("signup_succeeded", self, "_on_Auth_signup_succeeded")
	Firebase.Auth.connect("signup_failed", self, "_on_Auth_signup_failed")
	Firebase.Auth.connect("auth_request", self, "_on_Auth_auth_request")

	Firebase.Auth.check_auth_file()


# Self functions
func generate_accesskey() -> String:
	randomize()
	var fruit_library: Array = ["Abricot", "Airelle", "Amande", "Ananas", "Avocat", "Banane"]
	var adjective_library: Array = ["Mysterieux", "duDemon", "Bonbon", "Sanguine", "Poilu", "Démoniaque"]
	
	return fruit_library[randi() % fruit_library.size()] + adjective_library[randi() % fruit_library.size()]
	
	
# Signal functions
func _on_Login_pressed() -> void:
	Firebase.Auth.login_with_email_and_password($TabContainer/Login/email.text, $TabContainer/Login/password.text)
	

func _on_ForgetPassword_pressed() -> void:
	Firebase.Auth.send_password_reset_email($TabContainer/Login/email.text)
	print("Password reset envoyé")


func _on_SignUp_pressed() -> void:
	_temp_input_infos = {"email": $TabContainer/SignUp/email.text, "password": $TabContainer/SignUp/password.text, "username": $TabContainer/SignUp/username.text}
	Firebase.Auth.signup_with_email_and_password(_temp_input_infos.email, _temp_input_infos.password)


func _on_Validate_pressed() -> void:
	var accesskey: String = $PopupAccessKey/ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/AccessKey.text
	
	var query: FirestoreQuery = FirestoreQuery.new()
	query.from("users")
	query.where("accesskey", FirestoreQuery.OPERATOR.EQUAL, accesskey)
	var query_task: FirestoreTask = Firebase.Firestore.query(query)
	var result: FirestoreTask = yield(query_task, "task_finished")
	
	if result.data.size() > 0:
		var users_collection: FirestoreCollection = Firebase.Firestore.collection("users")
		
		var user_update: FirestoreTask = users_collection.update(singleton_user_infos.uid, {"has_access": true})
		yield(user_update, "task_finished")
		
		var owner_user: FirestoreDocument = result.data[0]
		var invitees: Array = owner_user.doc_fields.invitees
		if not invitees.has(singleton_user_infos.username):
			invitees.append(singleton_user_infos.username)
		user_update = users_collection.update(owner_user.doc_name, {"invitees": invitees})
		
		popup_accesskey.set_visible(false)
		print("BRAVO VOUS ETES CONNECTE")
		
	else:
		print("Code invalide !")


func _on_Quitter_pressed() -> void:
	get_tree().quit()


func _on_Auth_auth_request(result_code, result_content) -> void:
	if result_code == 1:
		print(result_content.email)
		# Get user document
#		var users_collection: FirestoreCollection = Firebase.Firestore.collection("users")
#		users_collection.get(result_content.localid)
#
#		# Save in memory user infos
#		save_user_infos(result_content.localid, yield(users_collection, "get_document").doc_fields)


func _on_Auth_signup_succeeded(auth_infos: Dictionary) -> void:
	print("signup")
	# Create new user document
	_new_user_document_body.email = _temp_input_infos.email
	_new_user_document_body.username = _temp_input_infos.username
	_new_user_document_body.accesskey = generate_accesskey()
		
	var users_collection: FirestoreCollection = Firebase.Firestore.collection("users")
	var add_user_task: FirestoreTask = users_collection.add(auth_infos.localid, _new_user_document_body)
	yield(add_user_task, "add_document")
	
	# Save in memory user infos
	save_user_infos(auth_infos.localid, _new_user_document_body)
	
#	Firebase.Auth.save_auth(auth_infos)
	
	popup_accesskey.popup_centered_ratio(1.0)
	

func _on_Auth_login_succeeded(auth_infos: Dictionary) -> void:
	print("login")
	# Get user document
	var users_collection: FirestoreCollection = Firebase.Firestore.collection("users")
	users_collection.get(auth_infos.localid)
	
	# Save in memory user infos
	save_user_infos(auth_infos.localid, yield(users_collection, "get_document").doc_fields)
#
#	Firebase.Auth.save_auth(auth_infos)
	
	if not singleton_user_infos.has_access:
		popup_accesskey.popup_centered_ratio(1.0)
	else:
		print("BRAVO VOUS ETES CONNECTE en ", singleton_user_infos)


func _on_Auth_login_failed(code, message: String) -> void:
	print("error: ", code, "\nmessage: ", message)


func _on_Auth_signup_failed(code, message: String) -> void:
	print("error: ", code, "\nmessage: ", message)







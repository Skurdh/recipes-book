extends Control


func _ready():
	var file: File = File.new()
	var recipes_list: Array = []
	if file.file_exists("user://local_recipes/LOCAL_drafts.data"):
		var file_error: int = file.open("user://local_recipes/LOCAL_drafts.data", File.READ)
		if file_error == OK:
			var content = file.get_var()
			recipes_list = content if typeof(content) == TYPE_ARRAY else []
		file.close()
	
	
	Firebase.Auth.connect("login_succeeded", self, "_on_FirebaseAuth_login_succeeded")
	Firebase.Auth.connect("signup_succeeded", self, "_on_FirebaseAuth_login_succeeded")
	Firebase.Auth.connect("login_failed", self, "on_login_failed")
	Firebase.Auth.connect("signup_failed", self, "on_signup_failed")

func _on_login_pressed():
	var email =$HBoxContainer/email.text
	var password = $HBoxContainer/password.text
	Firebase.Auth.login_with_email_and_password(email, password)

func _on_register_pressed():
	var email =$HBoxContainer/email.text
	var password = $HBoxContainer/password.text
	Firebase.Auth.signup_with_email_and_password(email, password)

func _on_FirebaseAuth_login_succeeded(auth):
	var user = Firebase.Auth.get_user_data()
	print(user)
	
func on_login_failed(error_code, message):
	print("error code: " + str(error_code))
	print("message: " + str(message))

func on_signup_failed(error_code, message):
	print("error code: " + str(error_code))
	print("message: " + str(message))

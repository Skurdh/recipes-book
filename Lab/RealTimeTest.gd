"""
Script : NAME

"""
extends Control

# Signals

# Export variable

# Public variables
var db_ref: FirebaseDatabaseReference
# Onready variables


# Setter Getter Functions

# Callback functions

# Self functions
func _ready():
#	Firebase.Auth.login_with_email_and_password("jeancastex@gouv.frence", "jormun")
	Firebase.Auth.login_with_email_and_password("vinegraphe@gmail.com", "jormun")
	yield(get_tree().create_timer(3.0), "timeout")
	
	db_ref = Firebase.Database.get_database_reference("appdb/recipes", {})
	db_ref.connect("new_data_update", self, "_on_data_update")
	db_ref.connect("patch_data_update", self, "_on_patch_update")
	db_ref.connect("push_successful", self, "push_succ")
	$Button.set_disabled(false)
	
	
#	db_ref.update("recipe1", {"title": "Coucou la famille"})


# Signal functions
func push_succ():
	print("succe !")


func _on_data_update(data):
	var d = data
	
	print("New : ", data)


func _on_patch_update(data):
	print("Patch : ", data)


func _on_Button_pressed():
	db_ref.update("recette1", {"t": "essai"})

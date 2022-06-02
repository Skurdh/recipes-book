"""
Script : NAME

"""

extends Control

# Signals

# Export variable

# Public variables

# Onready variables
onready var signin_form: PanelContainer = $ColorRect/SignInPanel
onready var signup_form: PanelContainer = $ColorRect/SignUpPanel

onready var load_pck_scene: PackedScene = preload("res://src/scenes/Load.tscn")

# Setter Getter Functions

# Callback functions
func _ready() -> void:
	signin_form.get_create_account_button().connect("pressed", self, "on_SignIn_CreateAccount_button_pressed")
	signup_form.get_sign_in_button().connect("pressed", self, "on_SignUp_SignIn_button_pressed")
	
#	if not Firebase.Auth.check_auth_file():
#		signin_form.set_visible(true)
#	else:
#		_on_SignForm_succeeded()


# Self functions

# Signal functions
func on_SignIn_CreateAccount_button_pressed() -> void:
	signin_form.set_visible(false)
	signup_form.set_visible(true)


func on_SignUp_SignIn_button_pressed() -> void:
	signin_form.set_visible(true)
	signup_form.set_visible(false)


func _on_SignForm_succeeded() -> void:
	get_tree().change_scene_to(load_pck_scene)

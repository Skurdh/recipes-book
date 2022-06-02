"""
Script : NAME

"""

extends Node

# Signals

# Export variable

# Public variables
var infos: Dictionary = {}

# Onready variables


# Setter Getter Functions

# Callback functions

# Self functions
func get_profil() -> void:
	yield(get_tree(), "idle_frame")
	var users_collection: FirestoreCollection = Firebase.Firestore.collection("users")
	var get_task: FirestoreTask = users_collection.get(Firebase.Auth.auth.localid)
	var user_doc: FirestoreDocument = yield(get_task, "get_document")
	
	infos = user_doc.doc_fields
	infos.ID = user_doc.doc_name



func get_username() -> String:
	return infos.username

func get_id() -> String:
	return infos.ID
# Signal functions

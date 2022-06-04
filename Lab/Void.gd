extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum State {IDLE, WALK}

var state: int = State.IDLE setget set_state, get_state

func set_state(value: int) -> void:
	state = value
	print("SET STATE to ", value)


func get_state() -> int:
	print("GET STATE, ", state)
	return state


func _ready() -> void:
	state = State.IDLE
	# 

extends Node

signal moved(move_input:Vector2)

var last_input: Vector2

func _process(delta):
	var move_input = Input.get_vector("move_left", "move_right", "move_forward", "move_back").limit_length(1.0)
	if last_input != move_input:
		moved.emit(move_input)
	last_input = move_input

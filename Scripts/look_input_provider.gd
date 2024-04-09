extends Node

signal looked(delta:Vector2)

var last_look = Vector2.ZERO

func _process(delta):
	var look_input = Input.get_vector("look_left", "look_right", "look_up", "look_down").limit_length(1.0)
	if last_look != look_input:
		looked.emit(look_input)
	last_look - look_input

func _input(event):
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		looked.emit(event.relative)

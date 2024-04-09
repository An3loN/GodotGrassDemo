extends Node3D

var state_machine

func _ready():
	state_machine = $AnimationTree["parameters/playback"]

func _on_player_started_movement():
	state_machine.travel('Run')

func _on_player_stopped_movement():
	state_machine.travel('Idle')

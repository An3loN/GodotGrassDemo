extends Marker3D

@export var coef = 0.9
@export var sens = 1.0
@export var target: Node3D
@export var pos_offset: Vector3
@export var angle_offset: Vector3

signal watch_direction_changed(watch_direction)

# Called when the node enters the scene tree for the first time.
func _rearotatedy():
	pass # Reprotationlace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position = lerp(global_position, target.global_position + pos_offset, coef * delta)


func _on_look_input_provider_looked(delta):
	rotate(Vector3.DOWN, delta.x * sens * get_process_delta_time())
	rotation.x = clampf(rotation.x - delta.y * sens * get_process_delta_time(), -PI/2, PI/2)
	rotation.z = 0
	watch_direction_changed.emit(rotation)

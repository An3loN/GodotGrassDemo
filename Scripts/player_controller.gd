extends CharacterBody3D

const SPEED = 5.0

signal started_movement()
signal stopped_movement()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var move_input = Vector3.ZERO
var player_rotation_y = 0
var is_moving = false

func _process(delta):
	RenderingServer.global_shader_parameter_set("player_pos", position)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if(self.move_input): 
		if(not is_moving): switch_move_state()
		rotation.y = player_rotation_y - Vector2.DOWN.angle_to(move_input)
	else:
		if(is_moving): switch_move_state()
	var direction = Vector3(move_input.x, 0, move_input.y).rotated(Vector3.UP, player_rotation_y)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func switch_move_state():
	is_moving = not is_moving
	if(is_moving): started_movement.emit()
	else: stopped_movement.emit()

func _on_input_provider_moved(move_input):
	self.move_input = move_input

func _on_camera_makrer_watch_direction_changed(watch_direction):
	player_rotation_y = watch_direction.y

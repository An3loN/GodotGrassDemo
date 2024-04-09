extends Node3D

@export var grass_scene: PackedScene
@export var grass_layer = 2
@export var spawn_range = Vector2(10, 10)
@export var spawn_step = 0.5

const WORLD_HEIGHT = 1000.0

func spawn_grass(node3d: Node3D):
	var space_state = get_world_3d().direct_space_state
	
	# use global coordinates, not local to node
	var x = node3d.position.x - spawn_range.x/2
	while x < node3d.position.x + spawn_range.x/2:
		var y = node3d.position.z - spawn_range.y/2
		while y < node3d.position.z + spawn_range.y/2:
			var query = PhysicsRayQueryParameters3D.create(node3d.position + Vector3(x, WORLD_HEIGHT, y), node3d.position + Vector3(x, -WORLD_HEIGHT, y), pow(2, grass_layer-1))
			var result = space_state.intersect_ray(query)
			if result:
				var grass = grass_scene.instantiate()
				grass.position = result.position
				add_child(grass)
			y += spawn_step
		x += spawn_step
	
	


func _ready():
	spawn_grass(self)

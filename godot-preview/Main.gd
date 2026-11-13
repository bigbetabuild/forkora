extends Node3D

const PLAYER_SCRIPT = preload("res://Player.gd")

func _ready() -> void:
	_build_lighting()
	_build_map()
	_build_player()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _build_lighting() -> void:
	var world_env := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_SKY
	environment.sky = Sky.new()
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.66, 0.73, 0.88)
	environment.ambient_light_energy = 0.55
	world_env.environment = environment
	add_child(world_env)

	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-52.0, -28.0, 0.0)
	sun.light_energy = 1.15
	sun.shadow_enabled = true
	add_child(sun)

func _build_map() -> void:
	# A self-contained, original blockout map. No web services or game backend needed.
	_add_box("Ground", Vector3(80, 1, 80), Vector3(0, -0.5, 0), Color("34495e"))
	_add_box("SpawnPad", Vector3(12, 0.35, 10), Vector3(0, 0.18, 12), Color("26a69a"))
	_add_box("CentralPlaza", Vector3(20, 0.5, 18), Vector3(0, 0.25, -2), Color("7f8c8d"))

	# Low walls mark a simple walkable test area without enclosing the camera.
	_add_box("NorthWall", Vector3(80, 4, 1), Vector3(0, 2, -40), Color("263746"))
	_add_box("SouthWall", Vector3(80, 4, 1), Vector3(0, 2, 40), Color("263746"))
	_add_box("EastWall", Vector3(1, 4, 80), Vector3(40, 2, 0), Color("263746"))
	_add_box("WestWall", Vector3(1, 4, 80), Vector3(-40, 2, 0), Color("263746"))

	# Colored landmarks and obstacles make it easy to check movement and rendering.
	_add_box("RedTower", Vector3(5, 10, 5), Vector3(-15, 5, -12), Color("d35454"))
	_add_box("BlueTower", Vector3(5, 7, 5), Vector3(15, 3.5, -15), Color("4b83c3"))
	_add_box("YellowBlock", Vector3(7, 2, 5), Vector3(-14, 1, 8), Color("e0b84c"))
	_add_box("GreenBlock", Vector3(5, 3, 7), Vector3(14, 1.5, 9), Color("62a36b"))
	_add_box("LowObstacleA", Vector3(3, 1, 3), Vector3(-5, 0.5, -4), Color("c07b47"))
	_add_box("LowObstacleB", Vector3(3, 1, 3), Vector3(5, 0.5, -4), Color("c07b47"))

	# A few raised platforms for jumping and checking collision behavior.
	_add_box("PlatformA", Vector3(8, 1, 7), Vector3(-23, 1.5, 2), Color("7967a8"))
	_add_box("PlatformB", Vector3(8, 1, 7), Vector3(23, 1.5, -1), Color("7967a8"))
	_add_box("StepA", Vector3(4, 0.5, 4), Vector3(-20, 0.25, 7), Color("8b79ba"))
	_add_box("StepB", Vector3(4, 1, 4), Vector3(-23, 0.75, 4), Color("8b79ba"))

func _build_player() -> void:
	var player := CharacterBody3D.new()
	player.name = "PreviewPlayer"
	player.position = Vector3(0, 1.2, 16)
	player.set_script(PLAYER_SCRIPT)
	add_child(player)

	var collision := CollisionShape3D.new()
	var capsule := CapsuleShape3D.new()
	capsule.radius = 0.42
	capsule.height = 1.8
	collision.shape = capsule
	collision.position.y = 0.9
	player.add_child(collision)

	var camera := Camera3D.new()
	camera.name = "Camera3D"
	camera.position.y = 1.55
	camera.current = true
	player.add_child(camera)

func _add_box(box_name: String, size: Vector3, pos: Vector3, color: Color) -> void:
	var body := StaticBody3D.new()
	body.name = box_name
	body.position = pos
	add_child(body)

	var mesh_instance := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	mesh_instance.mesh = mesh
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.82
	mesh_instance.material_override = material
	body.add_child(mesh_instance)

	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = size
	collision.shape = shape
	body.add_child(collision)

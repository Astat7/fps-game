extends CharacterBody3D

var gun_range = 1000

var move_speed = 5.0
var jump_speed = 4.5
var free_mouse = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event) -> void:
	# rotate camera with mouse
	if event is InputEventMouseMotion and free_mouse == false:
		%Camera3D.rotation = Vector3(clamp(%Camera3D.rotation.x+(event.relative.y/-360), deg_to_rad(-90), deg_to_rad(90)), 0, 0)
		rotate_y(event.relative.x/-360)
	
	# fire
	if event is InputEventMouseButton and free_mouse == false:
		if event.button_index == 1 and event.pressed == true:
			var origin = %Camera3D.project_ray_origin(event.position)
			var ray = PhysicsRayQueryParameters3D.create(origin, origin + %Camera3D.project_ray_normal(event.position) * gun_range)
			var hit = get_world_3d().direct_space_state.intersect_ray(ray)
			if hit:
				var marker = load("res://Marker.tscn").instantiate()
				marker.position = hit.position
				get_node("/root/MainSpace").add_child(marker)

func _physics_process(delta: float) -> void:
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)

	move_and_slide()

func _process(_delta: float) -> void:
	# toggle free mouse
	if Input.is_action_just_pressed("free_mouse"):
		if free_mouse == false:
			free_mouse = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			free_mouse = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

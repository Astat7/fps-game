extends CharacterBody3D

var gun_range = 1000
var interact_range = 5

var max_ammo = 12
var ammo = 12
var health = 100
var max_health = 100

var move_speed = 5.0
var jump_speed = 4.5
var free_mouse = false
var bullet_speed = 0.005 # seconds per meter
var reload_time = 1

var reloading = false
var dead = false

# rotate camera with mouse
func rotate_camera(event) -> void:
	if free_mouse == true:
		return
	if !(event is InputEventMouseMotion):
		return

	%Camera3D.rotation = Vector3(clamp(%Camera3D.rotation.x+(event.relative.y/-540), deg_to_rad(-90), deg_to_rad(90)), 0, 0)
	rotate_y(event.relative.x/-540)
	#%Camera3D.rotation_degrees.y = lerp(%Camera3D.rotation_degrees.y, %Camera3D.rotation_degrees.y+event.relative.x, -0.2)
	#rotation_degrees.y = lerp(rotation_degrees.y, rotation_degrees.y+event.relative.x, -0.01)

func shoot(event) -> void:
	if free_mouse == true:
		return
	if !(event is InputEventMouseButton):
		return
	if event.button_index != 1:
		return
	if event.pressed == false:
		return
	if reloading == true:
		return
	if ammo < 1:
		reload(event, true)
		return
		
	%Camera3D.get_child(0).play()
	update_ammo(ammo-1)
		
	var origin = %Camera3D.project_ray_origin(event.position)
	var ray = PhysicsRayQueryParameters3D.create(origin, origin + %Camera3D.project_ray_normal(event.position) * gun_range)
	var hit = get_world_3d().direct_space_state.intersect_ray(ray)
	
	if !hit:
		return
	
	var tween = get_tree().create_tween()
	var marker = load("res://assets/models/Marker.tscn").instantiate()
	marker.position = self.position + Vector3(0, 3, 0)
	get_node("/root/MainSpace").add_child(marker)
	tween.tween_property(marker, "position", hit.position, marker.position.distance_to(hit.position)*bullet_speed)
	tween.tween_callback(marker.queue_free)

func interact(event) -> void:
	if free_mouse == true:
		return
	if !(event.is_action_pressed("interact")):
		return
		
	var origin = %Camera3D.project_ray_origin(get_viewport().get_visible_rect().size/2)
	var ray = PhysicsRayQueryParameters3D.create(origin, origin + %Camera3D.project_ray_normal(get_viewport().get_visible_rect().size/2) * interact_range)
	var hit = get_world_3d().direct_space_state.intersect_ray(ray)
	
	if !hit:
		return
	if !hit.collider:
		return
	if !hit.collider.has_method("interacted"):
		return
		
	hit.collider.interacted()
	
func reload(event, override=false):
	if free_mouse == true:
		return
	if !(event.is_action_pressed("reload")) and override == false:
		return
	if reloading == true:
		return
	reloading = true
	var tweenr = get_tree().create_tween()
	tweenr.tween_property(%Crosshair, "rotation", %Crosshair.rotation+PI, reload_time)
	tweenr.tween_callback(func ():
		update_ammo(max_ammo)
		reloading = false
		)

func update_health(new_value, new_max_value=max_health):
	max_health = new_max_value
	health = clamp(new_value, 0, max_health)
	%HealthBar.update(health, max_health)

func update_ammo(new_value, new_max_value=max_ammo):
	max_ammo = new_max_value
	ammo = clamp(new_value, 0, max_ammo)
	%AmmoLabel.update(ammo, max_ammo)

func process_jump() -> void:
	if !(Input.is_action_just_pressed("jump")):
		return
	if !is_on_floor():
		return
	velocity.y = jump_speed

func process_gravity(delta) -> void:
	if is_on_floor():
		velocity.y = 0
		return
	velocity += get_gravity() * delta
	
func passive_health_regen(delta):
	if dead == true:
		return
	if health >= max_health:
		return
	update_health(health+2*delta)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event) -> void:
	# rotate camera with mouse
	rotate_camera(event)
	# fire
	shoot(event)
	# interact
	interact(event)
	# reload
	reload(event)

func _physics_process(delta: float) -> void:
	# gravity
	process_gravity(delta)

	# jump
	process_jump()

	# passive health regeneration
	passive_health_regen(delta)

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
	if !(Input.is_action_just_pressed("free_mouse")):
		return
	if free_mouse == false:
		free_mouse = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		return
	free_mouse = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

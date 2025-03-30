extends Node3D

var moving = false
var opened = false

@onready var tween_left
@onready var tween_right
@onready var closed_position_left = Vector3(0, 0, 0.)
@onready var closed_position_right = Vector3(0, 0, 0)
@onready var opened_position_left = Vector3(0, 0, 0.7)
@onready var opened_position_right = Vector3(0, 0, -0.7)
@onready var speed = 1.5

func set_moving(state=false) -> void:
	moving = state

func open() -> void:
	set_moving(true)
	opened = true
	tween_left = get_tree().create_tween()
	tween_right = get_tree().create_tween()
	
	tween_left.tween_property($door_left, "position", opened_position_left, speed)
	tween_right.tween_property($door_right, "position", opened_position_right, speed)
	tween_left.tween_callback(set_moving)
	
func close() -> void:
	set_moving(true)
	opened = false
	tween_left = get_tree().create_tween()
	tween_right = get_tree().create_tween()
	
	tween_left.tween_property($door_left, "position", closed_position_left, speed)
	tween_right.tween_property($door_right, "position", closed_position_right, speed)
	tween_left.tween_callback(set_moving)

func button_pressed() -> bool:
	if moving == true:
		return false
	if opened == true:
		close()
		return true
	open()
	return true

extends Node3D

var current_level = 1

func generate_level():
	var new_level = load("res://level_template.tscn").instantiate()
	new_level.position.x = 32 * current_level
	add_child(new_level)
	
	current_level += 1

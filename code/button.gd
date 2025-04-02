extends Node3D

var locked = false
var used = false

func _on_interacted_signal() -> void:
	if locked == true:
		return
	var result = get_node(get_meta("door_path")).button_pressed()
	
	if result == false:
		return
	if used == true:
		return
	used = true
	get_tree().current_scene.generate_level()

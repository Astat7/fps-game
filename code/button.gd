extends Node3D

var locked = false
var used = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


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

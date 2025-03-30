extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size/2
	
	# refresh crosshair position
	get_tree().root.connect("size_changed", func():
		position = get_viewport_rect().size/2
	)

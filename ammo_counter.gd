extends Label

func update(ammo, max_ammo):
	text = str(ammo)+"/"+str(max_ammo)

func _ready() -> void:
	position = 5*get_viewport_rect().size/6/2
	
	# refresh position
	get_tree().root.connect("size_changed", func():
		position = 5*get_viewport_rect().size/6/2
	)

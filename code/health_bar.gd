extends ColorRect

@onready var SuperLabel = get_parent().get_parent()
@onready var max_health_bar_size = size.x

func update(health, max_health):
	size.x = max_health_bar_size * (health / max_health)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SuperLabel.position.x = get_viewport_rect().size.x/6
	SuperLabel.position.y = 5*get_viewport_rect().size.y/6
	
	# refresh position
	get_tree().root.connect("size_changed", func():
		SuperLabel.position.x = get_viewport_rect().size.x/6
		SuperLabel.position.y = 5*get_viewport_rect().size.y/6
	)

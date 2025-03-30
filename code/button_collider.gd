extends StaticBody3D

signal interacted_signal

func interacted() -> void:
	interacted_signal.emit()

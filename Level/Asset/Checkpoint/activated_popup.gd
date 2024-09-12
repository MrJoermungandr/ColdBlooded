extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Timer").timeout.connect(on_timeout)


func on_timeout():
	queue_free()

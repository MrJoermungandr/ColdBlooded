extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Button").pressed.connect(on_quit)
	
func on_quit():
	get_tree().quit()

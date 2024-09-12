extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Arrange/Button2").pressed.connect(on_credits)


func on_credits():
	get_node("Credits").visible=true

extends CharacterBody2D

@export
var speed = 20

func _process(delta: float) -> void:
	var desired_dir = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
	velocity = desired_dir * speed * delta

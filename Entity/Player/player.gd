extends CharacterBody2D

@export
var speed = 2000

var has_double_jumped: bool = false

func _process(delta: float) -> void:
	if is_on_floor():
		has_double_jumped = false
	_handle_input(delta)
	move_and_slide()
	if Input.is_action_just_pressed("move_jump"):
		if is_on_floor():
			velocity.y -= 50
		elif not has_double_jumped:
			velocity.y -= 50
			has_double_jumped = true


func _handle_input(delta: float):
	var hor_input = Input.get_axis("move_left", "move_right")
	velocity.x = hor_input * speed
	if not is_on_floor():
		velocity.y += delta * 10

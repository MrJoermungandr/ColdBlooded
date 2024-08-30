extends CharacterBody2D

@export
var speed = 2000

@export_group("Jump")
@export
var jump_height: float = 100
@export
var jump_time_to_peak: float = 0.5
@export
var jump_time_to_descend: float = 0.3

@onready
var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready
var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready
var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descend * jump_time_to_descend)) * -1

var has_double_jumped: bool = false

func _physics_process(delta: float) -> void:
	var is_on_floor = is_on_floor()
	if is_on_floor:
		has_double_jumped = false
	_handle_input(delta, is_on_floor)
	move_and_slide()

func _handle_input(delta: float, is_on_floor: bool):
	var hor_input = Input.get_axis("move_left", "move_right")
	velocity.x = hor_input * speed
	if not is_on_floor:
		velocity.y += get_current_gravity() * delta
	if Input.is_action_just_pressed("move_jump"):
		if is_on_floor:
			velocity.y = jump_velocity
		elif not has_double_jumped:
			velocity.y = jump_velocity
			has_double_jumped = true

func get_current_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity # ternary statement is back, hell yeah!

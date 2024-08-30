extends CharacterBody2D

@export
var speed = 2000

@export
var coyote_time_seconds: float = 0.1
var coyote_timer: Timer = Timer.new()
var is_coyote_completed: bool = false

@export_group("Jump")
@export
var jump_height_px: float = 90
@export
var jump_time_to_peak: float = 0.5
@export
var jump_time_to_descend: float = 0.4

@export
var second_jump_height_px: float = 54
@export
var second_jump_time_to_peak: float = 0.4
@export
var second_jump_time_to_descend: float = 0.3

@onready
var jump_velocity: float = ((2.0 * jump_height_px) / jump_time_to_peak) * -1
@onready
var jump_gravity: float = ((-2.0 * jump_height_px) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready
var fall_gravity: float = ((-2.0 * jump_height_px) / (jump_time_to_descend * jump_time_to_descend)) * -1

@onready
var second_jump_velocity: float = ((2.0 * second_jump_height_px) / second_jump_time_to_peak) * -1
@onready
var second_jump_gravity: float = ((-2.0 * second_jump_height_px) / (second_jump_time_to_peak * second_jump_time_to_peak)) * -1
@onready
var second_fall_gravity: float = ((-2.0 * second_jump_height_px) / (second_jump_time_to_descend * second_jump_time_to_descend)) * -1

var has_jumped: bool = false
var has_double_jumped: bool = false

func _ready() -> void:
	coyote_timer.one_shot = true
	coyote_timer.wait_time = coyote_time_seconds
	coyote_timer.timeout.connect(_on_coyote_complete)
	add_child(coyote_timer)

func _physics_process(delta: float) -> void:
	var is_on_ground = calc_is_on_ground()
	if is_on_ground:
		has_double_jumped = false
		has_jumped = false
	_handle_input(delta, is_on_ground)
	move_and_slide()

func _handle_input(delta: float, is_on_ground: bool):
	var hor_input = Input.get_axis("move_left", "move_right")
	velocity.x = hor_input * speed
	if not is_on_ground:
		velocity.y += get_current_gravity() * delta
	if Input.is_action_just_pressed("move_jump"):
		if is_on_ground:
			velocity.y = jump_velocity
			has_jumped = true
		elif not has_double_jumped:
			velocity.y = second_jump_velocity
			has_double_jumped = true

func get_current_gravity() -> float:
	if velocity.y < 0.0:	# ternary statement is back, hell yeah!
		return second_jump_gravity if has_double_jumped else jump_gravity
	else:
		return second_fall_gravity if has_double_jumped else fall_gravity

func calc_is_on_ground() -> bool:
	if is_on_floor():
		velocity.y = 0	#might be better to put this somewhere else
		is_coyote_completed = false
		return true
	elif is_coyote_completed or has_jumped or has_double_jumped:	#prevents gravity calculation being inaccurate
		return false
	elif coyote_timer.is_stopped():
		coyote_timer.start()
		return true
	return true

func _on_coyote_complete():
	is_coyote_completed = true

extends CharacterBody2D

@export
var entity_resource: EntityResource

@export
var speed = 2000

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

@export
var coyote_time_seconds: float = 0.1
var coyote_timer: Timer = Timer.new()
var is_coyote_completed: bool = false

@export
var glide_gravity: float = 80

var has_jumped: bool = false
var has_double_jumped: bool = false

var is_normal_hitbox_enabled: bool = true
@onready
var normal_collision: CollisionShape2D = $NormalCollision
@onready
var vertical_pinch_collision: CollisionShape2D = $VerticalPinchCollision
@onready
var animation_player: AnimationPlayer = $AnimationPlayer

@onready var state_machine: LimboHSM = $LimboHSM
@onready var attack_state: LimboState = $LimboHSM/attack
@onready var idle_state: LimboState = $LimboHSM/idle
@onready var move_state: LimboState = $LimboHSM/move

var is_facing_right = false

@onready
var _inital_health = entity_resource.health

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal death

func _ready() -> void:
	coyote_timer.one_shot = true
	coyote_timer.wait_time = coyote_time_seconds
	coyote_timer.timeout.connect(_on_coyote_complete)
	add_child(coyote_timer)
	vertical_pinch_collision.set_deferred("disabled", true)
	_init_state_machine()

func _init_state_machine():
	state_machine.add_transition(idle_state, move_state, &"move_started")
	state_machine.add_transition(move_state, idle_state, &"move_ended")
	state_machine.add_transition(state_machine.ANYSTATE, attack_state, &"atk_started")
	state_machine.add_transition(attack_state, move_state, attack_state.EVENT_FINISHED)
	state_machine.initial_state = idle_state
	state_machine.initialize(self)
	state_machine.set_active(true)

func _handle_input(delta: float, is_on_ground: bool):
	var hor_input = Input.get_axis("move_left", "move_right")
	if hor_input > 0.0:
		animated_sprite_2d.scale.x = 1.0
		is_facing_right = true
	elif hor_input < 0.0: # prevents facing a side by default
		animated_sprite_2d.scale.x = -1.0
		is_facing_right = false
	if not is_on_ground:
		velocity.y += get_current_gravity() * delta
		velocity.x = lerp(velocity.x, (velocity.x if is_zero_approx(hor_input) else hor_input * speed) * 0.7, .2)
	else:
		velocity.x = hor_input * speed
		velocity.y = 0
		animated_sprite_2d.play(&"Walk")
	_handle_jump_and_glide(is_on_ground)

func _handle_jump_and_glide(is_on_ground: bool) -> void:
	if Input.is_action_just_pressed("move_jump"):
		if is_on_ground:
			velocity.y = jump_velocity
			has_jumped = true
			animated_sprite_2d.play(&"Jump")
			_use_vertical_pinch_hitbox()
		elif not has_double_jumped:
			velocity.y = second_jump_velocity
			animated_sprite_2d.play(&"Jump")
			_use_vertical_pinch_hitbox()
			has_double_jumped = true
	if Input.is_action_pressed("move_jump"):
		if not is_on_ground and velocity.y > 0.0:
			velocity.y = glide_gravity
			animated_sprite_2d.play(&"Glide")

func get_current_gravity() -> float:
	if velocity.y < 0.0: # ternary statement is back, hell yeah!
		return second_jump_gravity if has_double_jumped else jump_gravity
	else:
		if not is_normal_hitbox_enabled: _use_normal_hitbox()
		return second_fall_gravity if has_double_jumped else fall_gravity

func calc_is_on_ground() -> bool:
	if is_on_floor():
		velocity.y = 0 # might be better to put this somewhere else
		is_coyote_completed = false
		return true
	elif is_coyote_completed or has_jumped or has_double_jumped or Input.is_action_pressed("move_back"): # prevents gravity calculation being inaccurate
		return false
	elif coyote_timer.is_stopped():
		coyote_timer.start()
		return true
	return true

func _on_coyote_complete():
	is_coyote_completed = true

func _use_vertical_pinch_hitbox():
	is_normal_hitbox_enabled = false
	normal_collision.set_deferred("disabled", true)
	vertical_pinch_collision.set_deferred("disabled", false)

func _use_normal_hitbox():
	is_normal_hitbox_enabled = true
	normal_collision.set_deferred("disabled", false)
	vertical_pinch_collision.set_deferred("disabled", true)

func take_damage(amount: int) -> void:
	if entity_resource.health - amount <= 0:
		entity_resource.health = 0
		death.emit() # TODO proper death handling
		state_machine.set_active(false)
		$Label.text = "dead"
		return
	entity_resource.health -= amount

func respawn_player(position:Vector2):
	global_position=position
	entity_resource.health = _inital_health
	velocity = Vector2.ZERO
	reactivate_state_machine.call_deferred()

func reactivate_state_machine():
	state_machine.set_active(true)

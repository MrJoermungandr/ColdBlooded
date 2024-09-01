extends LimboState

## Called once, when state is initialized.
func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	pass

## Called when state is exited.
func _exit() -> void:
	pass

## Called each frame when this state is active.
func _update(delta: float) -> void:
	var is_on_ground = agent.calc_is_on_ground()
	if is_on_ground:
		agent.has_double_jumped = false
		agent.has_jumped = false
	agent._handle_input(delta, is_on_ground)


func _handle_input(delta: float, is_on_ground: bool):
	var hor_input = Input.get_axis("move_left", "move_right")
	agent.velocity.x = hor_input * agent.speed
	if not is_on_ground:
		agent.velocity.y += agent.get_current_gravity() * delta
	agent._handle_jump_and_glide(is_on_ground)
	if is_zero_approx(hor_input) and not Input.is_action_pressed("move_jump"):
		dispatch(&"movement_ended")
	#if Input.is_action_just_pressed(&"attack_primary"):
		#animation_player.play(&"attack")
		#await animation_player.animation_finished

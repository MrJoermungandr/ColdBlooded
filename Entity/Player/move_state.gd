extends LimboState

## Called when state is entered.
func _enter() -> void:
	$"../../Label".text = "move"
	agent.animated_sprite_2d.play(&"Walk")

## Called each frame when this state is active.
func _update(delta: float) -> void:
	var is_on_ground = agent.calc_is_on_ground()
	if is_on_ground:
		agent.has_double_jumped = false
		agent.has_jumped = false
	agent._handle_input(delta, is_on_ground)
	if Input.is_action_just_pressed(&"attack_primary"):
		dispatch(&"atk_started")
		return
	agent.move_and_slide()
	if agent.velocity.is_zero_approx() and is_on_ground:
		dispatch(&"move_ended")

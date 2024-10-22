extends LimboState

## Called when state is entered.
func _enter() -> void:
	$"../../Label".text = "idle"
	agent.animated_sprite_2d.play(&"idle")

## Called each frame when this state is active. # TODO maybe play some idle animation or smth
func _update(delta: float) -> void:
	var is_on_floor = agent.calc_is_on_ground()
	if not is_on_floor:
		agent.velocity.y += agent.get_current_gravity() * delta
		agent.move_and_slide()
		return
	var input: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_back", &"move_jump")
	if not input.is_zero_approx():
		agent._handle_input(delta, is_on_floor)
		agent.move_and_slide()
		dispatch(&"move_started")
		return
	if Input.is_action_just_pressed(&"attack_primary"):
		dispatch(&"atk_started")
		return
	if Input.is_action_just_pressed(&"attack_ice_breath"):
		dispatch(&"ice_breath_started")
		return
	if Input.is_action_just_pressed(&"attack_pierce"):
		dispatch(&"pierce_attack_started")

extends LimboState

## Called once, when state is initialized.
func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	$"../../Label".text = "idle"

## Called when state is exited.
func _exit() -> void:
	pass

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
	if Input.is_action_just_pressed("attack_primary"):
		dispatch(&"atk_started")

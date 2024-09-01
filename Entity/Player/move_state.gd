extends LimboState

## Called once, when state is initialized.
func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	$"../../Label".text = "move"

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
	agent.move_and_slide()
	if agent.velocity.is_zero_approx() and is_on_ground:
		agent.state_machine.dispatch(&"move_ended")

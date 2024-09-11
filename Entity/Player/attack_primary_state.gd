extends LimboState

var can_enter: bool = true
var is_awaiting_timer: bool = false

## Called when state is entered.
func _enter() -> void:
	if not can_enter:
		agent.state_machine.dispatch(EVENT_FINISHED)
		return
	$"../../Label".text = "attack"
	agent.animation_player.play(&"attack", -1, 2.0)
	await agent.animation_player.animation_finished
	agent.state_machine.dispatch(EVENT_FINISHED)

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

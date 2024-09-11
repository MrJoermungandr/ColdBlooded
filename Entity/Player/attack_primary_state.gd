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

extends LimboState

var can_enter: bool = true
var is_awaiting_timer: bool = false

## Called once, when state is initialized.
func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	if not can_enter:
		agent.state_machine.dispatch(EVENT_FINISHED)
		return
	agent.label.text = "attack"
	agent.animation_player.play(&"attack", -1, 2.0)
	can_enter = false
	agent.state_machine.dispatch(EVENT_FINISHED)

## Called when state is exited.
func _exit() -> void:
	if is_awaiting_timer:
		return
	is_awaiting_timer = true
	await agent.animation_player.animation_finished
	can_enter = true
	is_awaiting_timer=false

## Called each frame when this state is active.
func _update(delta: float) -> void:
	pass

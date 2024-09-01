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

## Called each frame when this state is active. # TODO maybe play some idle animation or smth
func _update(delta: float) -> void:
	var hor_input: float = Input.get_axis("move_left", "move_right")
	if not is_zero_approx(hor_input) or Input.is_action_pressed("move_jump"):
		dispatch(&"movement_started")

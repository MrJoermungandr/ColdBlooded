extends LimboState

## Called once, when state is initialized.
func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	agent.animation_player.play(&"ice_breath")
	if $"../../AnimatedSprite2D/IceBreathRayCast".is_colliding():
		var collider = $"../../AnimatedSprite2D/IceBreathRayCast".get_collider()
		if collider is Node2D and collider.is_in_group(&"freezeable") and collider.has_method(&"freeze"):
			collider.freeze()
	await agent.animation_player.animation_finished
	dispatch(EVENT_FINISHED)

## Called when state is exited.
func _exit() -> void:
	pass

## Called each frame when this state is active.
func _update(delta: float) -> void:
	pass

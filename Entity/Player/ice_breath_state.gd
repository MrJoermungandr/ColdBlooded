extends LimboState

func _enter() -> void:
	if not agent.ice_breath_cooldown_timer.is_stopped():
		dispatch(EVENT_FINISHED)
		return
	agent.animation_player.play(&"ice_breath")
	if $"../../AnimatedSprite2D/IceBreathRayCast".is_colliding():
		var collider = $"../../AnimatedSprite2D/IceBreathRayCast".get_collider()
		if collider is Node2D and collider.is_in_group(&"freezeable") and collider.has_method(&"freeze"):
			collider.freeze()
	await agent.animation_player.animation_finished
	agent.ice_breath_cooldown_timer.start()
	dispatch(EVENT_FINISHED)

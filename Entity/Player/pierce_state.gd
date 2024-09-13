extends LimboState

## Called once, when state is initialized.
func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	agent.entity_resource.attack_type = EntityResource.dmg_type.PIERCE
	agent.animation_player.play(&"pierce")
	AudioManager.sound_player_melee()
	await agent.animation_player.animation_finished
	dispatch(EVENT_FINISHED)

## Called when state is exited.
func _exit() -> void:
	agent.entity_resource.attack_type = EntityResource.dmg_type.NORMAL

## Called each frame when this state is active.
func _update(delta: float) -> void:
	#the whole movement routine, but without animations or switching states
	var is_on_ground = agent.calc_is_on_ground()
	if is_on_ground:
		agent.has_double_jumped = false
		agent.has_jumped = false
	var hor_input = Input.get_axis("move_left", "move_right")
	if hor_input > 0.0:
		agent.animated_sprite_2d.scale.x = 1.0
		agent.is_facing_right = true
	elif hor_input < 0.0: # prevents facing a side by default
		agent.animated_sprite_2d.scale.x = -1.0
		agent.is_facing_right = false
	if not is_on_ground:
		agent.velocity.y += agent.get_current_gravity() * delta
		agent.velocity.x = lerp(agent.velocity.x, (agent.velocity.x if is_zero_approx(hor_input) else hor_input * agent.speed) * 0.7, .2)
	else:
		agent.velocity.x = hor_input * agent.speed
		agent.velocity.y = 0
	if Input.is_action_just_pressed("move_jump"):
		if is_on_ground:
			agent.velocity.y = agent.jump_velocity
			agent.has_jumped = true
			agent._use_vertical_pinch_hitbox()
		elif not agent.has_double_jumped:
			agent.velocity.y = agent.second_jump_velocity
			agent._use_vertical_pinch_hitbox()
			agent.has_double_jumped = true
	if Input.is_action_pressed("move_jump"):
		if not is_on_ground and agent.velocity.y > 0.0:
			agent.velocity.y = agent.glide_gravity
	agent.move_and_slide()

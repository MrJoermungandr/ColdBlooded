@tool
extends BTAction
## Selects the proper position for patrolling and stores it on the blackboard. [br]
## Returns [code]SUCCESS[/code].

@export var position_left_relative: float = 100.0

@export var position_right_relative: float = 100.0

@export var tolerance: float = 36.0

@export var fallback_steps_px: float = 18

@export var position_var: StringName = &"target_pos"

var initial_pos: Vector2

func _enter():
	initial_pos = blackboard.get_var(&"inital_pos")

# Display a customized name (requires @tool).
func _generate_name() -> String:
	return "Select Patrol Pos positions: [%s, %s]  ➜%s" % [
		position_left_relative, position_right_relative,
		LimboUtility.decorate_var(position_var)]

# Called each time this task is ticked (aka executed).
func _tick(_delta: float) -> Status:
	if agent.global_position.x - position_left_relative < tolerance:
		var offset = fallback_steps_px
		while offset < position_right_relative - tolerance:
			var pos = Vector2(initial_pos.x + position_right_relative - offset, agent.global_position.y)
			if not agent.is_good_position(pos):
				offset += fallback_steps_px
				continue
			blackboard.set_var(position_var, pos)
			return SUCCESS
		return FAILURE
	else:
		var offset = fallback_steps_px
		while offset < position_left_relative - tolerance:
			var pos = Vector2((initial_pos.x - position_left_relative) + offset, agent.global_position.y)
			if not agent.is_good_position(pos):
				offset += fallback_steps_px
				continue
			blackboard.set_var(position_var, pos)
			return SUCCESS
		return FAILURE

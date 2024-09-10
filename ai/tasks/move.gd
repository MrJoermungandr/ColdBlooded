@tool
extends BTAction
## Move

var walk_range: Vector2
var start_position: Vector2
var walk_left = false
var frames_since_blocked: int = 0

@export var target_position_var = &"target_pos"
@export var speed_var = &"speed"
@export var tolerance = 50.0

# Display a customized name (requires @tool).
func _generate_name() -> String:
	return "Move"


# Called once during initialization.
func _setup() -> void:
	start_position = agent.position

# Called each time this task is exited.
func _exit() -> void:
	pass

func _enter() -> void:
	frames_since_blocked = 0

# Called each time this task is ticked (aka executed).
func _tick(delta: float) -> Status:
	var target_pos: Vector2 = blackboard.get_var(target_position_var, Vector2.ZERO)
	if target_pos.distance_to(agent.global_position) < tolerance:
		return SUCCESS

	var speed: float = blackboard.get_var(speed_var, 10.0)
	var dir: Vector2 = agent.global_position.direction_to(target_pos)

	var desired_velocity: Vector2 = dir.normalized() * speed
	agent.move(desired_velocity, delta)
	agent.update_facing()
	if agent.is_path_blocked():
		frames_since_blocked += 1
		if frames_since_blocked > 3:
			return FAILURE
		return RUNNING
	frames_since_blocked = 0
	return RUNNING


# Strings returned from this method are displayed as warnings in the behavior tree editor (requires @tool).
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	return warnings

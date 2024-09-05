@tool
extends BTAction
## Move

var walk_range: Vector2
var start_position: Vector2
var walk_left = false

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


# Called each time this task is ticked (aka executed).
func _tick(_delta: float) -> Status:
	var target_pos: Vector2 = blackboard.get_var(target_position_var, Vector2.ZERO)
	if target_pos.distance_to(agent.global_position) < tolerance:
		return SUCCESS

	var speed: float = blackboard.get_var(speed_var, 10.0)
	#var dist: float = absf(agent.global_position.x - target_pos.x)
	var dir: Vector2 = agent.global_position.direction_to(target_pos)

	var desired_velocity: Vector2 = dir.normalized() * speed
	agent._set_velocity(desired_velocity)
	agent.update_facing()
	return RUNNING
	#if walk_left:
		#if agent.position.x - walk_range <= 0:
			#walk_left = false
			#return RUNNING
	#else:
		#pass
	#return SUCCESS


# Strings returned from this method are displayed as warnings in the behavior tree editor (requires @tool).
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	return warnings

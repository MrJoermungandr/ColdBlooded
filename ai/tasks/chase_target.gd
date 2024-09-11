@tool
extends BTAction

# Task parameters.
@export var target_var: StringName = &"target"
@export var tolerance = 18
@export var speed_var = &"speed"
@export var max_chase_distance: float = 126
var frames_since_blocked: int = 0

var target: CharacterBody2D
var is_target_invalid: bool = true

## Note: Each method declaration is optional.
## At minimum, you only need to define the "_tick" method.


# Called to generate a display name for the task (requires @tool).
func _generate_name() -> String:
	return "Chase Target"


# Called to initialize the task.
func _setup() -> void:
	pass


# Called when the task is entered.
func _enter() -> void:
	target = blackboard.get_var(target_var)
	if target == null or not target is CharacterBody2D:
		printerr("target doesn't exist! returning FAILURE")
	is_target_invalid = false
	frames_since_blocked= 0


# Called when the task is exited.
func _exit() -> void:
	target = null
	agent.velocity = Vector2.ZERO


# Called each time this task is ticked (aka executed).
func _tick(delta: float) -> Status:
	if is_target_invalid:
		return FAILURE
	var distance_to_target = target.global_position.distance_to(agent.global_position)
	if distance_to_target < tolerance:
		return SUCCESS
	if distance_to_target > max_chase_distance:
		agent.velocity = Vector2.ZERO
		blackboard.set_var(target_var, null)
		return FAILURE

	var speed: float = blackboard.get_var(speed_var, 10.0)
	var dir: Vector2 = agent.global_position.direction_to(target.global_position)
	dir.y = 0

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


# Strings returned from this method are displayed as warnings in the editor.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	return warnings

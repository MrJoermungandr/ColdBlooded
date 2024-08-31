extends Node


func set_elapsed_time(time:float):
	get_node("Label").text=str(time).pad_decimals(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

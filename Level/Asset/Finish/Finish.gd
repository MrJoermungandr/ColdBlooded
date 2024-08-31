extends Node2D
class_name Finish

signal level_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().finish=self
	#TODO make the monitor only detect player
	get_node("Area").body_entered.connect(func(_unused):level_finished.emit())

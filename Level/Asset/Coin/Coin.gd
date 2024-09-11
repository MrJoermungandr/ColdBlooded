extends Node2D

signal pickup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Area2D").body_entered.connect(on_pickup)
	var count=get_tree().root.get_child_count()
	var level=get_tree().root.get_child(count-1)
	level.register_coin(self)

func on_pickup(_unused):
	pickup.emit()
	
	queue_free()
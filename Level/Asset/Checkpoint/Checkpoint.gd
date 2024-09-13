extends Node2D



@onready
var popup=preload("res://Level/Asset/Checkpoint/ActivatedPopup.tscn")

var level

func _ready() -> void:
	get_node("Area2D").body_entered.connect(on_checkpoint_collected)
	var count=get_tree().root.get_child_count()
	level=get_tree().root.get_child(count-1)


func on_checkpoint_collected(_ja):
	if !is_node_ready(): return
	level.checkpoint_pickup(self.global_position)
	#print(self.global_position)
	add_child(popup.instantiate())

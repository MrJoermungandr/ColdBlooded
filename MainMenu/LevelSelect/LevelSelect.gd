extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Label").text=get_name()
	get_node("Button").pressed.connect(on_play_pressed)


func on_play_pressed():
	var scene=load("res://Level/"+get_name()+".tscn")
	get_tree().change_scene_to_packed(scene)

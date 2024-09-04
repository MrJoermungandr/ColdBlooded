extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("VerticalEntrys/LevelName/Label").text=get_name()
	get_node("VerticalEntrys/PlayLevel/Button").pressed.connect(on_play_pressed)
	if GameManger.save.runs.has(get_name()):
		get_node("VerticalEntrys/LocalRecord").record_time=GameManger.save.runs[get_name()].level_time


func on_play_pressed():
	var scene=load("res://Level/"+get_name()+".tscn")
	get_tree().change_scene_to_packed(scene)

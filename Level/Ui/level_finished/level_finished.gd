extends CenterContainer

@onready
var LevelTime=get_node("Panel/MarginContainer/VBoxContainer/HBoxContainer/Label")

func _ready() -> void:
	get_node("Panel/MarginContainer/VBoxContainer2/HBoxContainer/Button").pressed.connect(on_main_menu)
	get_node("Panel/MarginContainer/VBoxContainer2/HBoxContainer/Button2").pressed.connect(on_retry)

func on_main_menu():
	var scene= load("res://MainMenu.tscn")
	get_tree().change_scene_to_packed(scene)


#TODO
func set_finished(run:LevelRun):
	LevelTime.text=str(run.level_time).pad_decimals(3)
	visible=true
	
func on_retry():
	get_tree().paused=false
	get_tree().reload_current_scene()

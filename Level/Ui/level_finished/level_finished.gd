extends CenterContainer

@onready
var LevelTime=get_node("Panel/MarginContainer/VBoxContainer/HBoxContainer/Label")

func _ready() -> void:
	get_node("Panel/MarginContainer/VBoxContainer2/HBoxContainer/Button").pressed.connect(on_main_menu)

func on_main_menu():
	var scene= load("res://MainMenu.tscn")
	get_tree().change_scene_to_packed(scene)


#TODO
func set_finished(run:LevelRun):
	LevelTime.text=str(run.level_time).pad_decimals(3)
	visible=true

extends CenterContainer

@onready
var LevelTime=get_node("Panel/MarginContainer/VBoxContainer/HBoxContainer/Label")

#TODO
func set_finished(run:LevelRun):
	LevelTime.text=str(run.level_time).pad_decimals(3)
	visible=true

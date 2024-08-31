extends CenterContainer

#TODO
func set_finished(run:LevelRun):
	get_node("Label").text=str(run.level_time).pad_decimals(3)
	visible=true

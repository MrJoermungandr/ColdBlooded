extends Node

@onready
var save: GameSave


func _ready():
	#try to load game save
	var loaded_save:GameSave=load("user://save.tres")
	#if there is no resource yet make one and save
	if loaded_save==null:
		var new_save=GameSave.new()
		ResourceSaver.save(new_save,"user://save.tres")
		loaded_save=new_save
	#initialize the variable
	save=loaded_save


func submit_new_run(run:LevelRun):
	if save.runs.find_key(run.level_name):
		var old_run= save.runs.get(run.level_name)
		if old_run.level_time > run.level_time:
			save.runs[run.level_name]=run
	else:
		var exists:Array
		exists.append(run)
		save.runs[run.level_name]=run
	#TODO update the other params
	
	#TODO if logged in submit to leaderboard
	
	#finally save resource
	ResourceSaver.save(save)
	

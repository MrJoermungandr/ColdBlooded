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
	#TODO update the other params like coins
	
	
	#if its a new pb then submit
	if save.runs.find_key(run.level_name):
		var old_run= save.runs.get(run.level_name)
		if old_run.level_time > run.level_time:
			save.runs[run.level_name]=run
		else:
			#no pb so we can savely return from the function
			ResourceSaver.save(save)
			return
	else:
		save.runs[run.level_name]=run
	
	#submit the run to leaderboard
	LeaderboardManager.submit_pb(run)
	
	#finally save resource
	ResourceSaver.save(save)

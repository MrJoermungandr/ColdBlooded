extends Resource
class_name LevelRun


#no export because doesnt get stored only used for passing the run around
var level_name:String=""

#set on creation
@export_storage
var level_time:float

#when the run happened
@export_storage
var time_string:String=Time.get_datetime_string_from_system()

@export_storage
var time_hash:int

func construct(name:String,time:float):
	level_name=name
	level_time=time
	var input=time_string+str(time)+level_name
	time_hash=hash(input)

#TODO maybe store metadata like enemys defeated or coins collected

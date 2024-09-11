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

@export_storage
var is_coin_percent:bool=false

@export_storage
var coins:Dictionary

func construct(name:String,time:float):
	level_name=name
	level_time=time
	var input=time_string+str(time)+level_name
	time_hash=hash(input)
	
func set_collected_coins(new_coins:Dictionary):
	coins=new_coins
	var has_all_coins=true
	for key in coins.keys():
			if coins[key] == false:
				has_all_coins=false
	if has_all_coins:
		is_coin_percent=true
	
func get_collected_coins_count() -> String:
	var collected_coins=0
	for value in coins.values():
		if value ==true:
			collected_coins+=1
	return str(collected_coins)+"/"+str(coins.size())

#TODO maybe store metadata like enemys defeated or coins collected

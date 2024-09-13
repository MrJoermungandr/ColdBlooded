extends Node

func _ready() -> void:
	get_node("MarginContainer/ProgressBar").value=get_node("MarginContainer/ProgressBar").max_value 

func set_total_coins(count:int):
	get_node("MarginContainer/Label2").text="Coins: "+"0"+"/"+str(count)

func set_elapsed_time(time:float):
	get_node("MarginContainer/HBoxContainer/Label").text=str(time).pad_decimals(1)

func set_collected_coins(collected:int,count:int):
	get_node("MarginContainer/Label2").text="Coins: "+str(collected)+"/"+str(count)

var initial_health=null

func player_health_changed(res:EntityResource):
	if initial_health==null:
		initial_health=res.health
		print(res.health)
		get_node("MarginContainer/ProgressBar").max_value =initial_health
		#get_node("MarginContainer/ProgressBar").value =initial_health
	get_node("MarginContainer/ProgressBar").value=initial_health-res.health

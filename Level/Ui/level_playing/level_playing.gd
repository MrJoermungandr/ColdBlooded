extends Node


func set_elapsed_time(time:float):
	get_node("MarginContainer/Label").text=str(time).pad_decimals(3)

func set_collected_coins(count:int):
	get_node("MarginContainer/Label2").text="Coins: "+str(count)

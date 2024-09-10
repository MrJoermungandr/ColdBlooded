extends Node

@export
var record_position:int=0:
	set(value):
		record_position=value
		_ready()

@export
var record_name:String="":
	set(value):
		record_name=value
		_ready()

@export
var record_time:float=.0:
	set(value):
		record_time=value
		_ready()


func _ready() -> void:
	if record_position==1:
		get_node("Rank").text="1:"
		get_node("Name").text=record_name
	elif record_position==0:
		get_node("Rank").text="PB:"
	else:
		get_node("Rank").text=str(record_position)+":"
		get_node("Name").text=record_name
	get_node("Time").text= str(record_time).pad_decimals(3)

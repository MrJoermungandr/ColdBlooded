extends Node2D

@onready
var finish: Finish:
	set(value):
		finish=value
		finish.level_finished.connect(on_level_finished)

var elapsed_time:float=0.:
	set(value):
		elapsed_time=value
		playing_ui.set_elapsed_time(elapsed_time)
		

static var coins:int=0:
	set(value):
		coins=value
		print(value)

@onready
var playing_ui:Control=preload("res://Level/Ui/level_playing.tscn").instantiate()

@onready
var finish_ui:CenterContainer=preload("res://Level/Ui/level_finished.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	var static_ui_layer=CanvasLayer.new()
	add_child(static_ui_layer)
	static_ui_layer.add_child(finish_ui)
	static_ui_layer.add_child(playing_ui)
	finish_ui.visible=false

	 
func _process(delta):
	elapsed_time+=delta

func on_level_finished():
	var finish_time:float=elapsed_time
	
	#pause game
	
	#initialize new run
	var level_name:String=get_name()
	var level_run = LevelRun.new()
	level_run.construct(level_name,finish_time)
	#TODO maybe manipulate other fields in run
	
	#register run in GameManager
	GameManger.submit_new_run(level_run)
	get_tree().paused = true
	#show winscreen
	finish_ui.set_finished(level_run)
	
	
func register_coin(coin):
	coin.pickup.connect(func():coins+=1)

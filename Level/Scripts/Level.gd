extends Node2D

var finish_half_point: float = 0

@onready
var finish: Finish:
	set(value):
		finish = value
		finish.level_finished.connect(on_level_finished)
		finish_half_point = finish.global_position.y / 2

var elapsed_time: float = 0.:
	set(value):
		elapsed_time = value
		playing_ui.set_elapsed_time(elapsed_time)


var coins_in_level: int = 0:
	set(value):
		coins_in_level = value
		if is_node_ready():
			playing_ui.set_total_coins(value)

var collected_coins: int = 0:
	set(value):
		collected_coins = value
		playing_ui.set_collected_coins(value, coins_in_level)

var coins: Dictionary

var respawn_position: Vector2 = Vector2(0, 0)

@onready
var playing_ui: Control = preload("res://Level/Ui/level_playing.tscn").instantiate()

@onready
var finish_ui: CenterContainer = preload("res://Level/Ui/level_finished.tscn").instantiate()

@onready
var pause_ui: CenterContainer = preload("res://Level/Ui/level_paused.tscn").instantiate()

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	var static_ui_layer = CanvasLayer.new()
	add_child(static_ui_layer)
	static_ui_layer.add_child(finish_ui)
	static_ui_layer.add_child(playing_ui)
	static_ui_layer.add_child(pause_ui)
	finish_ui.visible = false

	#if player dies respawn him
	#SAFETY: array access 0 should be fine since only 1 player is active at a time
	get_tree().get_nodes_in_group("player")[0].death.connect(respawn_player)
	player = get_tree().get_nodes_in_group("player")[0]

var already_called = false
func _process(delta):
	elapsed_time += delta

	#Make unsigned to work in both direcitons
	if abs(player.global_position.y) > abs(finish_half_point):
		banger_percussion(!already_called)
		already_called = true
	if already_called && (abs(player.global_position.y) + 10.0 < abs(finish_half_point)):
		banger_percussion(!already_called)
		already_called = false
func on_level_finished():
	var finish_time: float = elapsed_time

	#pause game

	#initialize new run
	var level_name: String = get_name()
	var level_run = LevelRun.new()
	level_run.construct(level_name, finish_time)
	level_run.set_collected_coins(coins)
	#TODO maybe manipulate other fields in run

	#register run in GameManager
	GameManger.submit_new_run(level_run)
	get_tree().paused = true
	#show winscreen
	finish_ui.set_finished(level_run)


func register_coin(coin):
	coin.pickup.connect(register_coin_pickup)
	coins[coin.global_position] = false
	coins_in_level += 1

func register_coin_pickup(position: Vector2):
	coins[position] = true
	collected_coins += 1
	AudioManager.sound_coin()

func checkpoint_pickup(new_respawn_position: Vector2):
	respawn_position = new_respawn_position
	#Fornow
	AudioManager.sound_coin()

func respawn_player():
	#SAFETY: array access 0 should be fine since only 1 player is active at a time
	get_tree().get_nodes_in_group("player")[0].respawn_player(respawn_position)
	
func banger_percussion(start: bool):
	if start:
		AudioManager.set_switch_under50hp()
	else:
		AudioManager.set_switch_over50hp()

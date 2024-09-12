extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Load Soundbanks
	Wwise.load_bank("Init")
	Wwise.load_bank("Soundbank1")
	#post music
	Wwise.register_game_obj(self,"Game Object Name")
	Wwise.post_event("Music",self)
#States
func set_state_main_menu():
	Wwise.set_state("Gamestate","MainMenu")
func set_state_level():
	Wwise.set_state("Gamestate","Level")
func set_state_gameover():
	Wwise.set_state("Gamestate","GameOver")
	
#Switches
func set_switch_over50hp():
	Wwise.set_switch("PlayerHealth","Over50Hp",self)
func set_switch_under50hp():
	Wwise.set_switch("PlayerHealth","Under50Hp",self)

	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Load Soundbanks
	Wwise.load_bank("Init")
	Wwise.load_bank("Soundbank1")
	#post music
	Wwise.register_game_obj(self,"AudioManager")
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

#GameParameters
func set_sound_volume(volume: float):
	Wwise.set_rtpc_value("SoundVolume",volume,null)
func set_music_volume(volume:float):
	Wwise.set_rtpc_value("MusicVolume",volume,null)
func set_annoyance_volume(volume:float):
	Wwise.set_rtpc_value("AnnoyanceVolume",volume,null)
func set_paused():
	Wwise.set_rtpc_value("PausedLowPass",86.0,null)
func set_unpaused():
	Wwise.set_rtpc_value("PausedLowPass",0.0,null)

#SFX Events
#Player
func sound_coin():
	Wwise.post_event("Coin",self)
func sound_jump():
	Wwise.post_event("Jump",self)
func sound_left_foot():
	Wwise.post_event("PlayerLeftFoot",self)
func sound_right_foot():
	Wwise.post_event("PlayerRightFoot",self)
func sound_player_death():
	Wwise.post_event("PlayerDeath",self)
func sound_player_melee():
	Wwise.post_event("PlayerMelee",self)
func sound_player_ice_blast():
	Wwise.post_event("PlayerIceBlast",self)
func sound_player_hit():
	Wwise.post_event("PlayerHit",self)
#Enemy
func sound_enemy_melee(enemy :Object):
	Wwise.register_game_obj(enemy,"Enemy")
	Wwise.post_event("EnemyMelee",enemy)
func sound_enemy_lazer_blast(enemy:Object):
	Wwise.register_game_obj(enemy,"Enemy")
	Wwise.post_event("EnemyLazerBlast",enemy)
func sound_enemy_flame_blast(enemy:Object):
	Wwise.register_game_obj(enemy,"Enemy")
	Wwise.post_event("EnemyFlameBlast",enemy)
	
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

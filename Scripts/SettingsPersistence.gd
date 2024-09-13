extends Node

const settings_path = "user://settings.tres"
var game_settings: SettingsResource

var use_fullscreen: bool:
	get:
		return game_settings.use_fullscreen
	set(value):
		game_settings.use_fullscreen = value
		save_settings()
var sound_volume: float:
	get:
		return game_settings.sound_volume
	set(value):
		game_settings.sound_volume=value
		save_settings()
var music_volume: float:
	get:
		return game_settings.music_volume
	set(value):
		game_settings.music_volume=value
		save_settings()
var annoyance_volume: float:
	get:
		return game_settings.annoyance_volume
	set(value):
		game_settings.annoyance_volume=value
		save_settings()
func _ready():
	load_settings()
	if use_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	AudioManager.set_sound_volume(sound_volume)
	AudioManager.set_music_volume(music_volume)
	AudioManager.set_annoyance_volume(annoyance_volume)
func load_settings():
	if not FileAccess.file_exists(settings_path):
		game_settings = SettingsResource.new()
		save_settings()
	else:
		game_settings = ResourceLoader.load(settings_path, "SettingsResource")

func save_settings():
	if ResourceSaver.save(game_settings, settings_path) == OK:
		print("Saved game Settings succesfully")
	else:
		push_error("Error while saving the game Settings!")

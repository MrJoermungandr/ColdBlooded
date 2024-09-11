extends Node

const settings_path = "user://settings.tres"
var game_settings: SettingsResource = preload("res://Ui/SettingsMenu/GameSettings.tres")

var use_fullscreen: bool:
	get:
		return game_settings.use_fullscreen
	set(value):
		game_settings.use_fullscreen = value
		save_settings()

func _ready():
	load_settings()
	if use_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func load_settings():
	var disk_settings: SettingsResource = validate_settings()
	if(disk_settings == null):
		return
	game_settings=disk_settings

func validate_settings():
	if not FileAccess.file_exists(settings_path):
		save_settings()
		return null
	var disk_settings: SettingsResource = ResourceLoader.load(settings_path, "SettingsResource")
	return disk_settings

func save_settings():
	if ResourceSaver.save(game_settings, settings_path) == OK:
		print("Saved game Settings succesfully")
	else:
		push_error("Error while saving the game Settings!")

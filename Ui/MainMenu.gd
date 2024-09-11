extends Control


@onready
var Leaderboard=get_node("Middle/Leaderboard")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Leaderboard.visible=false
	$SettingsMenu.visible = false

func _on_settings_button_pressed() -> void:
	$SettingsMenu.visible = true
	toggle_visibility_of_everythin_except_settings(false)


func _on_settings_menu_exit() -> void:
	$SettingsMenu.visible = false
	toggle_visibility_of_everythin_except_settings(true)

func toggle_visibility_of_everythin_except_settings(toggled_on: bool):
	$Titel.visible = toggled_on
	$Profile.visible = toggled_on
	$Middle.visible = toggled_on
	$Settings.visible = toggled_on

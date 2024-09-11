extends MarginContainer

signal exit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/TabContainer/Graphics/MarginContainer/VBoxContainer/FullscreenToggle.button_pressed = SettingsPersistence.use_fullscreen


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		exit.emit()


func _on_back_button_pressed() -> void:
	exit.emit()


func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	SettingsPersistence.use_fullscreen = toggled_on
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

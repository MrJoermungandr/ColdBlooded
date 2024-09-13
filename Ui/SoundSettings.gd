extends TabBar

@onready var music_slider: HSlider = $MarginContainer/VBoxContainer/MusicSlider
@onready var sound_slider: HSlider = $MarginContainer/VBoxContainer/SoundSlider
@onready var annoyance_slider: HSlider = $MarginContainer/VBoxContainer/AnnoyanceSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	music_slider.set_value_no_signal(SettingsPersistence.music_volume)
	sound_slider.set_value_no_signal(SettingsPersistence.sound_volume)
	annoyance_slider.set_value_no_signal(SettingsPersistence.annoyance_volume)

func _on_music_slider_changed(value :float):
	AudioManager.set_music_volume(value)
	SettingsPersistence.music_volume=value
func _on_sound_slider_changed(value:float):
	AudioManager.set_sound_volume(value)
	SettingsPersistence.sound_volume=value
func _on_annoyance_slider_changed(value:float):
	AudioManager.set_annoyance_volume(value)
	SettingsPersistence.annoyance_volume=value
func _on_sound_slider_stop(changed:bool):
	AudioManager.sound_player_death()
func _on_annoyance_slider_stop(changed:bool):
	AudioManager.sound_jump()

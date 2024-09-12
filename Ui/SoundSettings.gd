extends TabBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_music_slider_changed(value: int):
	AudioManager.set_music_volume(value)

func _on_sound_slider_changed(value: int):
	AudioManager.set_sound_volume(value)

func _on_annoyance_slider_changed(value:int):
	AudioManager.set_annoyance_volume(value)

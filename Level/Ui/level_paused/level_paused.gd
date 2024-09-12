extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=false
	get_node("Panel/MarginContainer/VBoxContainer/Button").pressed.connect(on_main_menu)
	get_node("Panel/MarginContainer/VBoxContainer/Button2").pressed.connect(on_resumed)
	get_node("Panel/MarginContainer/VBoxContainer/Button4").pressed.connect(on_restart)
	get_node("Panel/MarginContainer/VBoxContainer/Button3").pressed.connect(on_respawn)

func on_main_menu():
	var scene= load("res://MainMenu.tscn")
	get_tree().change_scene_to_packed(scene)

#TODO this is most likely not ideal but who cares about one process function no time
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_game") && !visible:
		visible=true
		get_tree().paused=true

func on_resumed():
	visible=false
	get_tree().paused=false

func on_restart():
	get_tree().reload_current_scene()
	
func on_respawn():
	#SAFETY: only way this is used is when instantiated through the level so its safe to access level with janky double get_parent
	visible=false
	get_tree().paused=false
	get_parent().get_parent().respawn_player()

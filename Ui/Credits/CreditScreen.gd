extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=false
	get_node("CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Button").pressed.connect(on_closed)
	
func on_closed():
	visible=false

extends CenterContainer


@onready
var OkButton=get_node("Panel/MarginContainer/VBoxContainer/HBoxContainer/Button")

@onready
var CloseButton=get_node("Panel/MarginContainer/VBoxContainer/HBoxContainer2/Button")

var username:String=""
var password:String=""

var signup:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OkButton.pressed.connect(on_pressed_ok)
	get_node("Panel/MarginContainer/VBoxContainer/Username/LineEdit").text_changed.connect(on_username_changed)
	get_node("Panel/MarginContainer/VBoxContainer/Password/LineEdit").text_changed.connect(on_password_changed)
	
	LeaderboardManager.login_status_changed.connect(on_login_status_changed)
	
	CloseButton.pressed.connect(on_closed)
	get_node("Panel/MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/CheckButton").toggled.connect(on_toggled)
	get_node("Panel/MarginContainer/VBoxContainer/Repeat").visible=false
	
func on_username_changed(new:String):
	#TODO validation
	username=new
func on_password_changed(new:String):
	#TODO validation
	password=new
	
func on_pressed_ok():
	#TODO validation
	if signup:
		LeaderboardManager.signup(username,password)
	else:
		LeaderboardManager.login(username,password)


func on_login_status_changed(new:bool):
	if new:
		visible=false


func on_closed():
	visible=false


func on_toggled(new:bool):
	signup=new
	get_node("Panel/MarginContainer/VBoxContainer/Repeat").visible=signup

extends MarginContainer

@onready
var LogInButton=get_node("HBoxContainer/SignUpLogIn")
@onready
var LogOutButton=get_node("HBoxContainer/LogOut")
@onready
var LogInWindow=get_node("LogInWindow")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LogInWindow.visible=false
	if !LeaderboardManager.is_logged_in && GameManger.save.has_been_logged_in:
		#TODO popup to relog in 
		pass
	elif !LeaderboardManager.is_logged_in:
		print("mhm")
		LogInButton.visible=true
		LogOutButton.visible=false
	else:
		LogInButton.visible=false
		LogOutButton.visible=true
	LogInButton.pressed.connect(on_login_pressed)
	
	
func on_login_pressed():
	LogInWindow.visible=true

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
	on_login_status_changed(LeaderboardManager.is_logged_in)
	
	LogInButton.pressed.connect(on_login_pressed)
	LeaderboardManager.login_status_changed.connect(on_login_status_changed)
	LogOutButton.pressed.connect(on_logout_pressed)
	
func on_login_pressed():
	LogInWindow.visible=true

func on_login_status_changed(new:bool):
	if new:
		LogInButton.visible=false
		LogOutButton.visible=true
	else:
		LogInButton.visible=true
		LogOutButton.visible=false

func on_logout_pressed():
	GameManger.save.jwt=""
	ResourceSaver.save(GameManger.save)
	LeaderboardManager.is_logged_in=false

extends Control


@onready
var Leaderboard=get_node("Middle/Leaderboard")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Leaderboard.visible=false

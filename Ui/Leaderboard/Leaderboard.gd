extends PanelContainer

var leaderboard_entry=preload("res://Ui/Leaderboard/LeaderboardEntry.tscn")

@onready
var entry_container=get_node("MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LeaderboardManager.main_menu_leaderboard=self

func show_level(level_name:String):
	get_node("MarginContainer/VBoxContainer/Label").text="Leaderboard " +level_name
	var request=HTTPRequest.new()
	add_child(request)
	request.request_completed.connect(on_leaderboard_entries_retrieved)
	request.request(LeaderboardManager.API_URL+"/times/"+level_name)
	await request.request_completed
	remove_child(request)
	visible=true

func on_leaderboard_entries_retrieved(result,response_code,headers,body):
	if response_code==200:
		for child in entry_container.get_children():
			entry_container.remove_child(child)
		var parsed_body=JSON.parse_string(body.get_string_from_utf8())
		var iter_count=1
		for entry in parsed_body:
			var node=leaderboard_entry.instantiate()
			node.record_position=iter_count
			node.record_name=entry.username
			node.record_time=entry.time
			entry_container.add_child(node)
			iter_count+=1
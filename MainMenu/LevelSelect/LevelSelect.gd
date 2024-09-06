extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("VerticalEntrys/LevelName/Label").text=get_name()
	get_node("VerticalEntrys/PlayLevel/Button").pressed.connect(on_play_pressed)
	if GameManger.save.runs.has(get_name()):
		get_node("VerticalEntrys/LocalRecord").record_time=GameManger.save.runs[get_name()].level_time
		
	var request=HTTPRequest.new()
	add_child(request)
	request.request_completed.connect(on_leaderboard_entries_retrieved)
	request.request(LeaderboardManager.API_URL+"/times/"+get_name())
	await request.request_completed
	remove_child(request)

func on_leaderboard_entries_retrieved(result,response_code,headers,body):
	if response_code==200:
		var parsed_body=JSON.parse_string(body.get_string_from_utf8())
		var iter_count=1
		for entry in parsed_body:
			var node=get_node("VerticalEntrys/TopPositions/LeaderboardEntry"+str(iter_count))
			node.record_position=iter_count
			node.record_name=entry.username
			node.record_time=entry.time
			iter_count+=1
			if iter_count==3:
				break

func on_play_pressed():
	var scene=load("res://Level/"+get_name()+".tscn")
	get_tree().change_scene_to_packed(scene)

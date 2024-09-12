extends MarginContainer

@export
var Level: PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Level ==null :
		return
	var level_name=Level.instantiate().get_name()
	get_node("LevelSelect/MarginContainer/VerticalEntrys/LevelName/Label").text=level_name
	get_node("LevelSelect/MarginContainer/VerticalEntrys/PlayLevel/Button").pressed.connect(on_play_pressed)
	if GameManger.save.runs.has(level_name):
		get_node("LevelSelect/MarginContainer/VerticalEntrys/LocalRecord").record_time=GameManger.save.runs[level_name].level_time
		get_node("LevelSelect/MarginContainer/VerticalEntrys/LevelName/Coins/Label2").text=GameManger.save.runs[level_name].get_collected_coins_count()
		
	var request=HTTPRequest.new()
	add_child(request)
	request.request_completed.connect(on_leaderboard_entries_retrieved)
	request.request(LeaderboardManager.API_URL+"/times/"+level_name)
	await request.request_completed
	remove_child(request)
	
	mouse_entered.connect(show_leaderboard)
	mouse_exited.connect(func(): LeaderboardManager.hide_leaderboard())

func on_leaderboard_entries_retrieved(result,response_code,headers,body):
	if response_code==200:
		var parsed_body=JSON.parse_string(body.get_string_from_utf8())
		var iter_count=1
		for entry in parsed_body:
			var node=get_node("LevelSelect/MarginContainer/VerticalEntrys/TopPositions/LeaderboardEntry"+str(iter_count))
			node.record_position=iter_count
			node.record_name=entry.username
			node.record_time=entry.time
			iter_count+=1
			if iter_count==3:
				break
		#TODO this is super dumb ideially just spawn them in in the above for loop
		if iter_count==1:
			get_node("LevelSelect/MarginContainer/VerticalEntrys/TopPositions/LeaderboardEntry"+str(iter_count)).queue_free()
			iter_count+=1
		if iter_count==2:
			get_node("LevelSelect/MarginContainer/VerticalEntrys/TopPositions/LeaderboardEntry"+str(iter_count)).queue_free()
			iter_count+=1
		if iter_count==3:
			get_node("LevelSelect/MarginContainer/VerticalEntrys/TopPositions/LeaderboardEntry"+str(iter_count)).queue_free()

func on_play_pressed():
	AudioManager.set_state_level()
	get_tree().change_scene_to_packed(Level)
	
func show_leaderboard():
	if Level ==null :
		return
	var level_name=Level.instantiate().get_name()
	LeaderboardManager.show_leaderboard(level_name)

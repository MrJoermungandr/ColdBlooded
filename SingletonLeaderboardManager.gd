extends Node

const API_URL:String="http://localhost:3000"

@onready
var post_requester=HTTPRequest.new()
@onready
var get_requester=HTTPRequest.new()

@onready
var auth_header=PackedStringArray():
	set(value):
		var jwt=GameManger.save.jwt
		auth_header.append("Authorization: Bearer "+jwt)

@onready
var is_logged_in:bool=false

func _ready():
	auth_header=auth_header
	add_child(get_requester)
	add_child(post_requester)
	get_requester.request_completed.connect(check_logged_in,ConnectFlags.CONNECT_ONE_SHOT)
	get_requester.request(API_URL+"/is_logged_in",auth_header)
	await get_requester.request_completed
	print(is_logged_in)

func submit_pb(run:LevelRun):
	if !is_logged_in:
		return
	var request=HTTPRequest.new()
	request.request(API_URL,)
	await request.request_completed


func get_level_leaderboard(level_name:String):
	#TODO
	pass

func check_logged_in(result,response_code,headers,body):
	if response_code==200:
		is_logged_in=true

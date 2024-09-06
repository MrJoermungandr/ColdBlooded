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
		auth_header.append("Content-Type: application/json")

@onready
var is_logged_in:bool=false

func _ready():
	auth_header=auth_header
	add_child(get_requester)
	add_child(post_requester)
	get_requester.request_completed.connect(check_logged_in,ConnectFlags.CONNECT_ONE_SHOT)
	get_requester.request(API_URL+"/auth/is_logged_in",auth_header)
	await get_requester.request_completed

func submit_pb(run:LevelRun):
	if !is_logged_in:
		return
	post_requester.request_completed.connect(check_logged_in,ConnectFlags.CONNECT_ONE_SHOT)
	var jwt=GameManger.save.jwt
	#DOESNT WORK NOBODY KNOWS WHY
	post_requester.request(API_URL+"/times/submit/"+run.level_name,["Authorization: Bearer"+ jwt,"Content-Type: application/json"],HTTPClient.METHOD_POST,JSON.stringify({"level_time":run.level_time}))
	await post_requester.request_completed

func response_test(result,response_code,headers,body):
	print("9sudhgshdg")
	print(response_code)

func get_level_leaderboard(level_name:String):
	#TODO
	pass

func check_logged_in(result,response_code,headers,body):
	print(response_code)
	if response_code==200:
		var parsed_body=JSON.parse_string(body.get_string_from_utf8())
		GameManger.save.jwt=parsed_body.access_token
	if response_code==202: #ACCEPTED
		is_logged_in=true
		
func login(username:String,password:String):
	post_requester.request_completed.connect(check_logged_in,ConnectFlags.CONNECT_ONE_SHOT)
	post_requester.request(API_URL+"/auth/login",["Content-Type: application/json"],HTTPClient.METHOD_POST,JSON.stringify(
	{"username":username,"password":password}))
	await post_requester.request_completed

extends CharacterBody2D

@export
var patrol_cooldown_time_sec: float = 7
var patrol_timer: Timer

@export
var entity_resource: EntityResource

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready
var sprite: AnimatedSprite2D = $Sprite
var is_facing_right: bool = true

signal death

var hsm: LimboHSM
var patrol_state: LimboState
var attack_state: LimboState
var frozen_state: LimboState

func _ready() -> void:
	patrol_timer = Timer.new()
	patrol_timer.wait_time = patrol_cooldown_time_sec
	patrol_timer.one_shot = true
	patrol_timer.timeout.connect(_on_patrol_timer_timeout)
	add_child(patrol_timer)
	_initialize_hsm()

func face_dir(dir: float) -> void:
	if dir > 0.0 and sprite.scale.x < 0.0:
		sprite.scale.x = 1.0;
		is_facing_right = true
		#_frames_since_facing_update = 0
	if dir < 0.0 and sprite.scale.x > 0.0:
		sprite.scale.x = -1.0;
		is_facing_right = false
		#_frames_since_facing_update = 0

func _initialize_hsm():
	hsm = LimboHSM.new()

	patrol_state = LimboState.new().named("patrol").call_on_enter(_on_patrol_enter)
	attack_state = LimboState.new().named("attack").call_on_enter(_on_attack_enter)
	frozen_state = LimboState.new().named("frozen").call_on_enter(_on_frozen_enter)

	add_child(hsm)
	hsm.add_child(patrol_state)
	hsm.add_child(attack_state)
	hsm.add_child(frozen_state)

	hsm.add_transition(patrol_state, attack_state, &"attack_started")
	hsm.add_transition(attack_state, patrol_state, attack_state.EVENT_FINISHED)
	hsm.add_transition(hsm.ANYSTATE, frozen_state, &"frozen_started")
	hsm.add_transition(frozen_state, patrol_state, frozen_state.EVENT_FINISHED)

	hsm.initial_state = patrol_state
	hsm.initialize(self)
	hsm.set_active(true)

func _on_patrol_enter():# TODO play animation and stuff
	patrol_timer.start()

func _on_attack_enter():
	animation_player.play(&"attack")
	await animation_player.animation_finished
	hsm.dispatch(hsm.EVENT_FINISHED)

func _on_patrol_timer_timeout():
	if hsm.get_active_state() == patrol_state:
		face_dir(-1 if is_facing_right else 1)
		patrol_timer.start()

func _on_frozen_enter():#TODO ice cube
	pass

func _on_player_detect_area_body_entered(body: Node2D) -> void:
	var active_state = hsm.get_active_state()
	if active_state == attack_state or active_state == frozen_state:
		return
	hsm.dispatch(&"attack_started")

func _take_damage(amount: int, type: EntityResource.dmg_type):
	if type == 1 and hsm.get_active_state() == frozen_state:
		death.emit() #TODO particle fx
		queue_free()
		return
	if entity_resource.health - amount <= 0:
		entity_resource.health = 0
		death.emit()
		queue_free()
		return
	entity_resource.health -= amount

class_name Agent
extends CharacterBody2D

@export
var entity_resource: EntityResource

var ice_death_particles: PackedScene = preload("res://Entity/ice_death_particles.tscn")

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") # apparently this can't be a

@onready var sprite: AnimatedSprite2D = $Sprite
var _frames_since_facing_update: int = 0
@onready var ice_sprite: Sprite2D = $IceSprite

signal death

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var bt_player: BTPlayer = $BTPlayer
@onready var ray_cast = $Sprite/RayCast2D

var is_facing_right: bool = false
var _moved_this_frame: bool = false
var frozen: bool = false

func _ready():
	ice_sprite.visible = false
	bt_player.blackboard.set_var(&"inital_pos", position)

func _physics_process(delta):
	_post_physics_process.call_deferred(delta)

func _post_physics_process(delta) -> void:
	if not _moved_this_frame:
		if not is_on_floor():
			velocity.y += GRAVITY * delta
		move_and_slide()
	_moved_this_frame = false
	if velocity.is_zero_approx():
		sprite.play(&"idle")
	else:
		sprite.play(&"Walk")

func freeze() -> void:
	frozen = true
	ice_sprite.visible = true
	bt_player.active = false

func is_path_blocked() -> bool:
	return ray_cast.is_colliding()

func move(new_velocity: Vector2, delta: float) -> void:
	velocity = lerp(velocity, new_velocity, 0.2)
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	move_and_slide()
	_moved_this_frame = true

func take_damage(amount: int, type: EntityResource.dmg_type): #TODO maybe need to do something with state
	if(frozen and type == EntityResource.dmg_type.PIERCE):
		death.emit()
		var death_particles: GPUParticles2D = ice_death_particles.instantiate()
		get_tree().root.add_child(death_particles)
		death_particles.global_position = global_position
		death_particles.emitting = true
		queue_free()
	if entity_resource.health - amount <= 0:
		death.emit()
		queue_free()
	entity_resource.health -= amount

func update_facing() -> void:
	_frames_since_facing_update += 1
	if _frames_since_facing_update > 3:
		face_dir(velocity.x)

#assume the character is facing da right
func face_dir(dir: float) -> void:
	if dir > 0.0 and sprite.scale.x < 0.0:
		sprite.scale.x = 1.0;
		is_facing_right = true
		_frames_since_facing_update = 0
	if dir < 0.0 and sprite.scale.x > 0.0:
		sprite.scale.x = -1.0;
		is_facing_right = false
		_frames_since_facing_update = 0

## Is specified position inside the arena (not inside an obstacle)?
func is_good_position(p_position: Vector2) -> bool:
	var space_state := get_world_2d().direct_space_state
	var params := PhysicsPointQueryParameters2D.new()
	params.position = p_position
	params.collision_mask = 1 # Obstacle layer has value 1
	var collision := space_state.intersect_point(params)
	return collision.is_empty()

func _on_detection_zone_body_entered(body: Node2D):
	if frozen:
		return
	if body.is_in_group("player"):
		bt_player.blackboard.set_var(&"target", body)
		bt_player.restart()

func play_sound_melee_attack():
	AudioManager.sound_enemy_melee(self)
	

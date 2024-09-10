class_name Agent
extends CharacterBody2D

@export
var entity_resource: EntityResource

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") # apparently this can't be a 

@onready var sprite: AnimatedSprite2D = $Sprite
var _frames_since_facing_update: int = 0

signal death

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var bt_player: BTPlayer = $BTPlayer
@onready var ray_cast = $Sprite/RayCast2D

var is_facing_right = false

func _ready():
	bt_player.blackboard.set_var(&"inital_pos", position)

func is_path_blocked() -> bool:
	return ray_cast.is_colliding()

func move(new_velocity: Vector2, delta: float) -> void:
	velocity = lerp(velocity, new_velocity, 0.2)
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	move_and_slide()

func take_damage(amount: int, knockback: Vector2): #TODO maybe need to do something with state
	apply_knockback(knockback)
	if entity_resource.health - amount <= 0:
		death.emit()
		queue_free() #TODO proper dying
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

func apply_knockback(knockback: Vector2, frames: int = 10):
	if knockback.is_zero_approx():
		return
	for i in range(frames):
		velocity = lerp(velocity, knockback, 0.2)
		move_and_slide()
		await get_tree().physics_frame


func _on_detection_zone_body_entered(body: Node2D):
	if body.is_in_group("player"):
		bt_player.blackboard.set_var(&"target", body)
		bt_player.restart()

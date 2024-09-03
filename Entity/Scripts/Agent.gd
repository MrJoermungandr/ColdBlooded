class_name Agent
extends CharacterBody2D

@export
var entity_resource: EntityResource

var is_flipped: bool = false

signal death

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var bt_player: BTPlayer = $BTPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _take_damage(amount: int, knockback: Vector2):
	apply_knockback(knockback)
	if entity_resource.health - amount <= 0:
		death.emit()
		queue_free() #TODO proper dying
	entity_resource.health -= amount

func apply_knockback(knockback: Vector2, frames: int = 10):
	if knockback.is_zero_approx():
		return
	for i in range(frames):
		velocity = lerp(velocity, knockback, 0.2)
		move_and_slide()
		await get_tree().physics_frame

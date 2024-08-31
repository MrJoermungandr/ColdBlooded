class_name Agent
extends CharacterBody2D

@export
var entity_resource: EntityResource

signal death

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _take_damage(amount: int, knockback: Vector2):
	if entity_resource.health - amount <= 0:
		death.emit()
		queue_free() #TODO proper dying
	entity_resource.health -= amount

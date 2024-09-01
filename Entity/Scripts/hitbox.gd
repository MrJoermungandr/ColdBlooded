class_name Hitbox
extends Area2D
#deals damage

@export
var entity_resource: EntityResource #for damage var

@export_group("Collision")
@export_flags_2d_physics
var collision_layer_override: int = 2
@export_flags_2d_physics
var collision_mask_override: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_layer = collision_layer_override
	collision_mask = collision_mask_override

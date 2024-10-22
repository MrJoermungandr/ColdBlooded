class_name Hurtbox
extends Area2D
#Receives Damage

@export_group("Collision")
@export_flags_2d_physics
var collision_layer_override: int = 0
@export_flags_2d_physics
var collision_mask_override: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_layer = collision_layer_override
	collision_mask = collision_mask_override
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null or hitbox.owner == owner:
		return
	if(owner.has_method(&"take_damage")):	#StringName is faster to compare
		owner.take_damage(hitbox.entity_resource.attack_damage, hitbox.entity_resource.attack_type)
	else:
		printerr("Attack Target '" + hitbox.owner.name + "' doesn't have take_damage method!")

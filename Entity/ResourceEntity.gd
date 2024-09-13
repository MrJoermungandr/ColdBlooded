class_name EntityResource
extends Resource

enum dmg_type {
	NORMAL, PIERCE
}

@export
var health: int =10

@export
var attack_damage: int=5

@export
var attack_type: dmg_type = dmg_type.NORMAL

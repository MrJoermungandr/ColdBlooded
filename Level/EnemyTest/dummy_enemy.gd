extends MeshInstance2D

@export
var entity_resource: EntityResource

@onready
var label: Label = $Label

func _process(_delta: float) -> void:
	label.text = str(entity_resource.health)

func take_damage(amount: int):
	if entity_resource.health - amount <= 0:
		queue_free()
	else:
		entity_resource.health -= amount

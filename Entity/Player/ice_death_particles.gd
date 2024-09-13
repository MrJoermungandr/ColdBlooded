extends GPUParticles2D

func _ready() -> void:
	finished.connect(_on_finished)

func _on_finished():
	queue_free()

extends Area2D

@export var speed = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed * delta
	if position.y < 0:
		queue_free()

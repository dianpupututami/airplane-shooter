extends RigidBody2D

var speed: float = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	apply_central_impulse(Vector2(-mass * speed, 0))
	if position.x < -32:
		queue_free()

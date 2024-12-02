extends Area2D

var shooter: Node 

var direction: Vector2
var speed: float = 1024


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and body != shooter:
		body.queue_free()
		queue_free()

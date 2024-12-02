extends Area2D

var speed: int = 256

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < -32:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		queue_free()
		get_parent().coin += 1

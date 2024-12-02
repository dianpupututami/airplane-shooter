extends RigidBody2D

var speed: float = 64 * 0.4
var animated_sprite
var bullet_scene = preload("res://scene/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animated_sprite.play("default")
	if Input.is_action_pressed("ui_up"):
		apply_central_impulse(Vector2(0, -mass * speed))
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(-30), 0.1)
	else:
		if animated_sprite.rotation < 0:
			animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(0), 0.1)
	
	if Input.is_action_pressed("ui_down"):
		apply_central_impulse(Vector2(0, mass * speed))
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(30), 0.1)
	else:
		if animated_sprite.rotation > 0:
			animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(0), 0.1)
			
	if Input.is_action_just_pressed('ui_accept'):
		var bullet = bullet_scene.instantiate()
		bullet.shooter = self
		bullet.position = self.position + Vector2(64, 0)
		bullet.direction = Vector2(1, 0)
		get_parent().add_child(bullet)

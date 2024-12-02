extends Node2D

@export var enemy_scene: PackedScene
var coins_scene = preload("res://scene/coin.tscn")

@export var spawn_offset: float = 64
var coin: int = 0
var game_is_running: bool

func _ready() -> void:
	new_game()

func new_game():
	# Reset variable
	coin = 0
	show_score()
	game_is_running = true
	get_tree().paused = false
	$gameOverPanel.hide()

func _process(delta: float) -> void:
	# show score
	show_score()
	
	if $player.position.x < 0:
		game_over()

func show_score() -> void:
	$labelCoin.text = "Coin: " + str(coin)

func game_over() -> void:
	get_tree().paused = true
	game_is_running = false
	$gameOverPanel/labelCoin.text = "Coin: " + str(coin)
	$gameOverPanel.show()

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.position.x = get_viewport().size.x + spawn_offset
	enemy.position.y = randf_range(28, get_viewport().size.y - 28)


func _on_conin_spawn_timer_timeout() -> void:
	var coin_patterns = randi_range(0, 3)

	 # Horizontal line pattern
	if coin_patterns == 0:
		var coin_count = randf_range(3, 5)  # Random number of coins in the line
		var starting_y = randf_range(28, get_viewport().size.y - 28)
		for i in range(coin_count):
			var coin = coins_scene.instantiate()
			coin.add_to_group("coin-spawn")
			coin.position.x = get_viewport().size.x + spawn_offset + i * 32
			coin.position.y = starting_y
			add_child(coin)
	# Diagonal line pattern (upward)
	elif coin_patterns == 1:
		var coin_count = randf_range(3, 5)  # Random number of coins in the line
		var starting_x = get_viewport().size.x + spawn_offset
		var starting_y = randf_range(28, get_viewport().size.y - 28)
		for i in range(coin_count):
			var coin = coins_scene.instantiate()
			coin.add_to_group("coin-spawn")
			coin.position.x = starting_x - i * 32  # Adjust spacing as needed
			coin.position.y = starting_y - i * 32  # Adjust spacing as needed
			add_child(coin)
	# Diagonal line pattern (downward)
	elif coin_patterns == 2:
		var coin_count = randf_range(3, 5)  # Random number of coins in the line
		var starting_x = get_viewport().size.x + spawn_offset
		var starting_y = randf_range(28, get_viewport().size.y - 28)
		for i in range(coin_count):
			var coin = coins_scene.instantiate()
			coin.add_to_group("coin-spawn")
			coin.position.x = starting_x - i * 32  # Adjust spacing as needed
			coin.position.y = starting_y + i * 32  # Adjust spacing as needed
			add_child(coin)

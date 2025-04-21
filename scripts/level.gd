extends Node2D

func _ready():
	# Player increase score by Coin
	for coin in get_tree().get_nodes_in_group("coin"):
		coin.coin_collected.connect($Player.add_score)
	# Player take damage by Spike
	for spike in get_tree().get_nodes_in_group("spike"):
		spike.was_hit.connect($Player.take_damage)
	# Player heal by Medicine
	for medicine in get_tree().get_nodes_in_group("medicine"):
		medicine.was_taken.connect($Player.heal)
	# Update UI score
	$Player.score_updated.connect($UI.update_score)
	# Show death message
	$Player.was_dead.connect($UI.toggle_dead_label)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

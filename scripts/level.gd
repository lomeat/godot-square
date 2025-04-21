extends Node2D

func _ready():
	# Player increase score by Coin
	for coin in get_tree().get_nodes_in_group("coin"):
		coin.coin_collected.connect($Player.add_score)
	# Update UI score
	$Player.score_updated.connect($UI.update_score)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

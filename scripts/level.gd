extends Node2D

@onready var player: Player = $Player
@onready var ui: UI = $UI

func _ready():
	# Player increase score by Coin
	for coin in get_tree().get_nodes_in_group("coin"):
		coin.coin_collected.connect(player.add_score)
	# Update UI score
	player.score_updated.connect(ui.update_score)
	# Player take damage by Spike
	for spike in get_tree().get_nodes_in_group("spike"):
		spike.was_hit.connect(player.take_damage)
	player.was_dead.connect(ui.show_dead_message)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

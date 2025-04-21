extends Area2D

var score_value = 5

signal coin_collected(score_value: int)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		coin_collected.emit(score_value)
		queue_free()

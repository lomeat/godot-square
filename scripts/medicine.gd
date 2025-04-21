extends Area2D

var health: int = 3

signal was_taken(health: int)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		was_taken.emit(health)
		queue_free()

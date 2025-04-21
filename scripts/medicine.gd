extends Area2D

signal was_taken(health: int)

var health: int = 3

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		was_taken.emit(health)
		queue_free()

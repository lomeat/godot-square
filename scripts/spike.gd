extends Area2D

signal was_hit(damage: int, position: Vector2)

var damage: int = 1

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		was_hit.emit(damage, global_position)

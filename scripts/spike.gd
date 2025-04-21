extends Area2D

var damage = 1

signal was_hit(damage: int, source_position: Vector2)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		was_hit.emit(damage, global_position)

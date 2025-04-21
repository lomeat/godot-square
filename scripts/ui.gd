class_name UI
extends CanvasLayer

@onready var score: Label = $Score
@onready var dead: Label = $Dead

func update_score(value: int):
	score.text = "Score: " + str(value)

func show_dead_message(is_dead: bool):
	dead.visible = is_dead
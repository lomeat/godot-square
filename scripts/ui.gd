class_name UI
extends CanvasLayer

func update_score(value: int):
	var label = $Score
	label.text = "Score: " + str(value)

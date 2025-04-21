class_name UI
extends CanvasLayer

@onready var dead_label: Label = $Dead
@onready var score_label: Label = $Score

func _ready() -> void:
	dead_label.visible = false
	
func update_score(value: int):
	score_label.text = "Score: " + str(value)

func toggle_dead_label(is_visible: bool) -> void:
	dead_label.visible = is_visible

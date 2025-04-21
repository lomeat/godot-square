class_name Player
extends CharacterBody2D

signal score_updated(score: int)

@export var SPEED = 500.0
@export var JUMP_FORCE = -1100.0

var score := 0

func _physics_process(delta: float) -> void:
	movement(delta)
	move_and_slide()

func movement(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

	# Movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 5)
		
		
func add_score(value):
	score += value
	score_updated.emit(score)
class_name Player
extends CharacterBody2D

signal score_updated(score: int)
signal was_dead(is_dead: bool)

@onready var sprite: Sprite2D = $Sprite2D

@export var SPEED = 500.0
@export var JUMP_FORCE = -1100.0
@export var max_health := 3
@export var textures: Array[Texture2D] = [
	preload("res://sprites/square-1.png"), # 1hp, full
	preload("res://sprites/square-2.png"), # 2hp
	preload("res://sprites/square-3.png"), # 3hp, last
]

var score := 0
var current_health := max_health
var was_damaged := false

func _ready() -> void:
	was_dead.emit(false)
	update_appearance()

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
	if direction and not was_damaged:
		velocity.x = direction * SPEED
	elif was_damaged:
		await get_tree().create_timer(0.1).timeout
		was_damaged = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 5)
		
		
func add_score(value):
	score += value
	score_updated.emit(score)

func update_appearance():
	var index = current_health - 1
	sprite.texture = textures[index]
	
func take_damage(amount: int, source_position: Vector2):
	current_health = max(current_health - amount, 0)
	update_appearance()
	
	if current_health <= 0:
		die()

	was_damaged = true
	var knockback_direction = global_position - source_position
	velocity = knockback_direction * 30 
	

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	update_appearance()
		
func die():
	was_dead.emit(true)
	queue_free()
	
	

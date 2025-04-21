class_name Player
extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

signal score_updated(score: int)
signal was_dead()

@export var SPEED = 500.0
@export var JUMP_FORCE = -1100.0
@export var max_health := 3
@export var textures: Array[Texture] = [
	preload("res://sprites/square-1.png"), # 1hp, last
	preload("res://sprites/square-2.png"), # 2hp
	preload("res://sprites/square-3.png"), # 3h, full
]

var score := 0
var current_health := max_health
var was_damage := false

func _ready() -> void:
	was_dead.emit(false)

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
	if direction and not was_damage:
		velocity.x = direction * SPEED
	elif was_damage:
		await get_tree().create_timer(0.1).timeout
		was_damage = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 5)
		
		
func add_score(value):
	score += value
	score_updated.emit(score)

func heal(amount: int):
	current_health = min(current_health + amount, max_health)
	update_apeerance()

func update_apeerance():
	var index = current_health - 1
	sprite.texture = textures[index]
	
func take_damage(damage: int, source_position) -> void:
	current_health = max(current_health - damage, 0)
	if current_health <= 0:
		die()

	was_damage = true
	update_apeerance()
	var knockback_direction = global_position - source_position
	velocity = knockback_direction * 30

func die():
	was_dead.emit(true)
	queue_free()
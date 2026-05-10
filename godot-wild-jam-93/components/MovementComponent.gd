extends Node
class_name MovementComponent

@export var body_to_move : CharacterBody2D
@export var speed : float = 600.0
@export var acceleration : float = 500.0
@export var drag : float = 100.0

var dir : Vector2

func _physics_process(delta: float) -> void:
	dir = Input.get_vector("left", "right", "up", "down")
	var velocity := dir * speed

	if dir == Vector2.ZERO:
		body_to_move.velocity = body_to_move.velocity.move_toward(Vector2.ZERO, delta * drag)
	else:
		body_to_move.velocity = body_to_move.velocity.move_toward(velocity, delta * acceleration)

	body_to_move.move_and_slide()

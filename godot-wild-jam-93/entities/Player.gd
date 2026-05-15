extends CharacterBody2D
class_name Player

@export var movement_component : MovementComponent
@export var state_machine : StateMachine
@onready var raycast : RayCast2D = $RayCast2D
@onready var left_spawn : Node2D = $LeftSpawn
@onready var right_spawn : Node2D = $RightSpawn

var active_chunk : Vector2i
var dir : Vector2 = Vector2.ZERO

func _ready() -> void:
	self.draw.connect(_on_draw)

func _on_draw() -> void:
	self.draw_rect(Rect2(position.x - 16.0, position.y - 16.0, 32.0, 32.0), Color.BLUE)
	self.draw_rect(Rect2(position.x + 16.0, position.y - 8.0, 8.0, 8.0), Color.BLUE)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("drilling"):
		$AnimatedSprite2D.play("drill_mode")
	if Input.is_action_just_pressed("hull_transition"):
		$AnimatedSprite2D.play("hull_transition")
	if Input.is_action_just_pressed("drill_transition"):
		$AnimatedSprite2D.play("drill_transition")

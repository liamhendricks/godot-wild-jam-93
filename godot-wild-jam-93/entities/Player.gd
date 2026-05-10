extends CharacterBody2D
class_name Player

@export var movement_component : MovementComponent

var active_chunk : Vector2i
var dir : Vector2 = Vector2.ZERO

func _ready() -> void:
	self.draw.connect(_on_draw)

func _on_draw() -> void:
	self.draw_rect(Rect2(position.x, position.y, 32.0, 32.0), Color.BLUE)

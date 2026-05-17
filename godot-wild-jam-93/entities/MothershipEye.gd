extends Node2D

func _ready() -> void:
	draw.connect(_on_draw)

func _on_draw():
	draw_circle(Vector2(0.0, 0.0), 25.0, Color.REBECCA_PURPLE)
	draw_circle(Vector2(8.0, 0.0), 8.0, Color.RED)

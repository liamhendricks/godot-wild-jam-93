extends RigidBody2D

@onready var collision_shape : CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	self.draw.connect(_on_draw)

func _on_draw() -> void:
	self.draw_rect(Rect2(position.x - 16.0, position.y - 16.0, 32.0, 32.0), Color.RED)
	self.draw_rect(Rect2(position.x + 16.0, position.y - 8.0, 8.0, 8.0), Color.RED)

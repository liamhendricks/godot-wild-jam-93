extends RigidBody2D
class_name Ore

@export var data : ResourceData
@export var size_px : float = 128.0

@onready var point_create_component : PointCreateComponent = $PointCreateComponent
@onready var collision_shape : CollisionPolygon2D = $CollisionPolygon2D

func _ready() -> void:
	draw.connect(_on_draw)
	collision_shape.polygon = point_create_component.create_convex_points(size_px)

func _on_draw() -> void:
	draw_colored_polygon(collision_shape.polygon, Color.AQUA)

extends RigidBody2D
class_name Asteroid

@onready var collision_shape : CollisionPolygon2D = $CollisionPolygon2D

const MAX_POINTS : int = 16
const MIN_POINTS : int = 12
const SIZE_PX : float = 128.0

func _ready() -> void:
	draw.connect(_on_draw)
	var r := GameManager.rng.randi_range(MIN_POINTS, MAX_POINTS)
	var points : PackedVector2Array = []
	for n in range(r):
		var x := GameManager.rng.randf_range(-SIZE_PX, SIZE_PX)
		var y := GameManager.rng.randf_range(-SIZE_PX, SIZE_PX)
		points.append(Vector2(x, y))

	var convex_points = Geometry2D.convex_hull(points)

	collision_shape.polygon = convex_points

func _on_draw() -> void:
	draw_colored_polygon(collision_shape.polygon, Color.SADDLE_BROWN)

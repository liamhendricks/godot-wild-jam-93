extends RigidBody2D
class_name Asteroid

@onready var collision_shape : CollisionPolygon2D = $CollisionPolygon2D
@onready var point_create_component : PointCreateComponent = $PointCreateComponent
@onready var polygon_split_component : PolygonSplitComponent = $PolygonSplitComponent

var position_key : Vector2
var uvs : PackedVector2Array

func _ready() -> void:
	draw.connect(_on_draw)

func create_points(size : float) -> void:
	collision_shape.polygon = point_create_component.create_convex_points(size)
	create_uvs(collision_shape.polygon)

func set_points(points : PackedVector2Array) -> void:
	var convex_points = Geometry2D.convex_hull(points)
	collision_shape.polygon = convex_points
	create_uvs(collision_shape.polygon)

func create_uvs(points : PackedVector2Array) -> void:
	var rect := Rect2(points[0], Vector2.ZERO)
	for p in points:
		rect = rect.expand(p)

	for p in points:
		var uv = (p - rect.position) / rect.size
		uvs.append(uv)

func split_polygon(dir : Vector2, point : Vector2) -> Array[PackedVector2Array]:
	return polygon_split_component.split_polygon(dir, point, collision_shape.polygon)

func _on_draw() -> void:
	draw_colored_polygon(collision_shape.polygon, Color.SADDLE_BROWN, uvs)

extends RigidBody2D
class_name Asteroid

@onready var collision_shape : CollisionPolygon2D = $CollisionPolygon2D
@onready var point_create_component : PointCreateComponent = $PointCreateComponent
@onready var polygon_split_component : PolygonSplitComponent = $PolygonSplitComponent

var position_key : Vector2

func _ready() -> void:
	draw.connect(_on_draw)

func create_points(size : float) -> void:
	collision_shape.polygon = point_create_component.create_convex_points(size)

func set_points(points : PackedVector2Array) -> void:
	var convex_points = Geometry2D.convex_hull(points)
	collision_shape.polygon = convex_points

func split_polygon(dir : Vector2, point : Vector2) -> Array[PackedVector2Array]:
	return polygon_split_component.split_polygon(dir, point, collision_shape.polygon)

func _on_draw() -> void:
	draw_colored_polygon(collision_shape.polygon, Color.SADDLE_BROWN)

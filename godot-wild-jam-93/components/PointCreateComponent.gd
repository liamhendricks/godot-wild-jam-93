extends Node
class_name PointCreateComponent

@export var max_points : int = 16
@export var min_points : int = 12

func create_convex_points(size_px : float) -> PackedVector2Array:
	var r := GameManager.rng.randi_range(min_points, max_points)
	var points : PackedVector2Array = []
	for n in range(r):
		var x := GameManager.rng.randf_range(-size_px, size_px)
		var y := GameManager.rng.randf_range(-size_px, size_px)
		points.append(Vector2(x, y))

	var convex_points = Geometry2D.convex_hull(points)
	if Geometry2D.is_polygon_clockwise(convex_points):
		convex_points.reverse()
	return convex_points

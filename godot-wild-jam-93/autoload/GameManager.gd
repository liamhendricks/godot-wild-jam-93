extends Node

enum RESOURCE_TYPES {ORE}

var rng : RandomNumberGenerator

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.seed = hash(Time.get_ticks_msec())


func get_centroid(points : PackedVector2Array) -> Vector2:
	if points.size() == 0:
		return Vector2.ZERO
	
	var center = Vector2.ZERO
	for p in points:
		center += p
	return center / points.size()

func get_polygon_area(points: PackedVector2Array) -> float:
	var triangles = Geometry2D.triangulate_polygon(points)
	var area = 0.0

	for i in range(0, triangles.size(), 3):
		var a = points[triangles[i]]
		var b = points[triangles[i+1]]
		var c = points[triangles[i+2]]
		area += abs((a.x * (b.y - c.y) + b.x * (c.y - a.y) + c.x * (a.y - b.y)) / 2.0)

	return area

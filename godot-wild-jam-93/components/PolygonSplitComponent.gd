extends Node
class_name PolygonSplitComponent

@export var shrink_modifier : float = 0.5

func split_polygon(dir : Vector2, point : Vector2, polygon : PackedVector2Array) -> Array[PackedVector2Array]:
	var normal := dir.normalized()
	var points := polygon

	var poly_a := PackedVector2Array()
	var poly_b := PackedVector2Array()

	for i in points.size():
		var a = points[i] * shrink_modifier
		var b = points[(i + 1) % points.size()] * shrink_modifier

		var da = normal.dot(a - point)
		var db = normal.dot(b - point)

		if da >= 0:
			poly_a.append(a)
		else:
			poly_b.append(a)

		if (da > 0 and db < 0) or (da < 0 and db > 0):
			var t = da / (da - db)
			var intersection = a.lerp(b, t)

			poly_a.append(intersection)
			poly_b.append(intersection)

	return [poly_a, poly_b]

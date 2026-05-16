extends Area2D
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

func _on_body_entered(node: Node2D) -> void:
	if "resource_collection_component" in node:
		SignalBus.resource_gathered.emit(data)
		node.resource_collection_component.pick_up(data)
		queue_free()

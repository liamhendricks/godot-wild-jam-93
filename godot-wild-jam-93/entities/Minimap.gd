extends Control
class_name Minimap

@export var minimap_scale : float = 0.05
@export var minimap_radius : float = 100.0
@export var world_range : float = 2000.0
var shape_generator : ShapeGenerator
var player : Player

func init(_player : Player, _shape_generator : ShapeGenerator) -> void:
	player = _player
	shape_generator = _shape_generator

func _draw() -> void:
	if not shape_generator:
		return

	var center = size * 0.5
	draw_circle(center, minimap_radius, Color(0,0,0,0.5))

	for world_pos in shape_generator.asteroid_positions.keys():
		var offset = world_pos - player.global_position
		var distance = offset.length()

		if distance > world_range:
			continue

		var normalized = offset / world_range

		var map_pos = center + normalized * minimap_radius

		draw_circle(map_pos, shape_generator.asteroid_size * minimap_scale, Color.SADDLE_BROWN)

	#player
	draw_circle(center, 4.0, Color.RED)

func _process(_delta):
	queue_redraw()

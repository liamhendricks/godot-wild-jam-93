extends Node
class_name ShapeGenerator

@export var noise_texture : NoiseTexture2D
@export var threshold : float = 0.5
@export var max_shapes : int = 512
@export var world_scale : float = 16.0
@export var chunk_size : int = 1024
@export var max_chunks : int = 9
@export var view_distance : int = 1
@export var player : Player

var half_chunk_size : float = 0.0
var chunks : Dictionary[Vector2i, bool] = {}
var pool : Array[Node2D] = []
var asteroids : Dictionary[Vector2i, Array] = {}
var noise_image : Image

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	if not noise_texture.changed.is_connected(_on_noise_texture_changed):
		noise_texture.changed.connect(_on_noise_texture_changed)

	await noise_texture.changed
	noise_image = noise_texture.get_image()
	assert(noise_image != null)
	half_chunk_size = chunk_size / 2

	for n in max_shapes:
		var node := Node2D.new()
		add_child(node)
		node.draw.connect(_on_draw.bind(node))
		pool.append(node)

	var visible_positions: Array[Vector2] = []
	for y in range(-view_distance, view_distance + 1):
		for x in range(-view_distance, view_distance + 1):
			var chunk = Vector2i(x, y)
			chunks[chunk] = true
			var a_positions = generate_chunk(chunk)
			asteroids[chunk] = a_positions
			enable_chunk(chunk)
			visible_positions.append_array(asteroids[chunk])

			print("created chunk")

	var count = min(pool.size(), visible_positions.size())
	for i in range(count):
		var obj = pool[i]
		obj.global_position = visible_positions[i]
		obj.visible = true

	for i in range(count, pool.size()):
		pool[i].visible = false

	player.active_chunk = Vector2i(0,0)
	set_process(true)

func _process(_delta : float) -> void:
	var ship_chunk = GameManager.world_to_chunk(player.global_position, chunk_size)
	if ship_chunk == player.active_chunk:
		return

	player.active_chunk = ship_chunk
	update_visible(ship_chunk)

func update_visible(ship_chunk : Vector2i) -> void:
	var visible_positions: Array[Vector2] = []
	for y in range(-view_distance, view_distance + 1):
		for x in range(-view_distance, view_distance + 1):
			var chunk = Vector2i(x + ship_chunk.x, y + ship_chunk.y)
			if chunk in chunks:
				var world_space_coords = GameManager.chunk_to_world(chunk, chunk_size)
				var dist = player.global_position.distance_to(world_space_coords)
				if dist > chunk_size + half_chunk_size:
					disable_chunk(chunk)
				else:
					if !chunks[chunk]:
						enable_chunk(chunk)
						visible_positions.append_array(asteroids[chunk])
				continue

			chunks[chunk] = true
			var a_positions = generate_chunk(chunk)
			asteroids[chunk] = a_positions
			visible_positions.append_array(asteroids[chunk])

	var count = min(pool.size(), visible_positions.size())

	for i in range(count):
		var obj = pool[i]
		obj.global_position = visible_positions[i]
		obj.visible = true

	for i in range(count, pool.size()):
		pool[i].visible = false

func enable_chunk(chunk : Vector2i):
	chunks[chunk] = true

func disable_chunk(chunk : Vector2i):
	chunks[chunk] = false

func generate_chunk(chunk : Vector2i) -> Array[Vector2]:
	var positions : Array[Vector2] = []
	var chunk_origin = GameManager.chunk_to_world(chunk, chunk_size)

	for i in range(max_shapes):
		var local_pos = Vector2(
			GameManager.rng.randf_range(0, chunk_size),
			GameManager.rng.randf_range(0, chunk_size)
		)

		var world_pos = chunk_origin + local_pos
		var density = sample_noise(world_pos)

		if density > threshold:
			positions.append(world_pos)

	return positions

func sample_noise(world_pos : Vector2) -> float:
	var x := int(floor(world_pos.x / world_scale)) % noise_texture.height
	var y := int(floor(world_pos.y / world_scale)) % noise_texture.width

	if x < 0:
		x += noise_texture.height
	if y < 0:
		y += noise_texture.width

	return noise_image.get_pixel(x, y).r

func _on_draw(node : Node2D) -> void:
	node.draw_circle(node.position, 5.0, Color.RED, true)

func _on_noise_texture_changed() -> void:
	pass

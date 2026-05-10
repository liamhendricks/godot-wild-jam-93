extends Node

var rng : RandomNumberGenerator

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.seed = hash(Time.get_ticks_msec())

func world_to_chunk(pos : Vector2, chunk_size : int) -> Vector2i:
	return Vector2i(
		round(pos.x / chunk_size),
		round(pos.y / chunk_size)
	)

func chunk_to_world(chunk_pos : Vector2i, chunk_size : int) -> Vector2:
	return Vector2(
		chunk_pos.x * chunk_size,
		chunk_pos.y * chunk_size
	)

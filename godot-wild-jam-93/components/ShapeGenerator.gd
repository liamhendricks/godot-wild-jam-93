extends Node2D
class_name ShapeGenerator

@export var noise_texture : NoiseTexture2D
@export var threshold : float = 0.3
@export var max_shapes : int = 128
@export var world_scale : float = 8.0
@export var player : Player

var noise_image : Image

var asteroid_scene = load("res://entities/Asteroid.tscn")

func _ready() -> void:
	if not noise_texture.changed.is_connected(_on_noise_texture_changed):
		noise_texture.changed.connect(_on_noise_texture_changed)

	await noise_texture.changed
	noise_image = noise_texture.get_image()
	assert(noise_image != null)

	draw()

func draw() -> void:
	for n in range(max_shapes):
		var local_pos = Vector2(
			GameManager.rng.randf_range(0.0, int(noise_texture.width)),
			GameManager.rng.randf_range(0.0, int(noise_texture.height))
		)
		var value := sample_noise(local_pos)
		if value < threshold:
			continue

		var node = asteroid_scene.instantiate()
		add_child(node)
		var centered_pos = local_pos - Vector2(
			noise_texture.width * 0.5,
			noise_texture.height * 0.5
		)

		var world_space = centered_pos * world_scale
		node.position = world_space

func sample_noise(pos : Vector2) -> float:
	return noise_image.get_pixel(int(pos.x), int(pos.y)).r

func _on_noise_texture_changed() -> void:
	pass

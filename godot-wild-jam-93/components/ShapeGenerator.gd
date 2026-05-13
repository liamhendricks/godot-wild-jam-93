extends Node
class_name ShapeGenerator

@export var noise_texture : NoiseTexture2D
@export var threshold : float = 0.3
@export var max_shapes : int = 128
@export var asteroid_size : float = 128.0
@export var world_scale : float = 2.0
@export var player : Player

var noise_image : Image
var asteroid_positions : Dictionary[Vector2, bool] = {}
var asteroid_scene = load("res://entities/Asteroid.tscn")

func _ready() -> void:
	SignalBus.asteroid_split.connect(_on_asteroid_split)
	noise_image = noise_texture.get_image()
	assert(noise_image != null)

	draw(max_shapes)

func draw(num_shapes : int) -> void:
	for n in range(num_shapes):
		var local_pos = Vector2(
			GameManager.rng.randf_range(0.0, int(noise_texture.width)),
			GameManager.rng.randf_range(0.0, int(noise_texture.height))
		)
		var value := sample_noise(local_pos)
		if value < threshold:
			continue

		var world_pos = get_world_position(local_pos)
		asteroid_positions[world_pos] = true
		var a := create_asteroid(local_pos)
		a.create_points(asteroid_size)

func create_asteroid(local_pos : Vector2) -> Asteroid:
	var asteroid = asteroid_scene.instantiate() as Asteroid
	GameManager.add_child(asteroid)
	var centered_pos = local_pos - Vector2(
		noise_texture.width * 0.5,
		noise_texture.height * 0.5
	)

	var world_space = centered_pos * world_scale
	asteroid.position = world_space
	asteroid.position_key = world_space

	return asteroid


func sample_noise(pos : Vector2) -> float:
	return noise_image.get_pixel(int(pos.x), int(pos.y)).r

func _on_noise_texture_changed() -> void:
	pass

func get_world_position(local_pos : Vector2) -> Vector2:
	var centered_pos = local_pos - Vector2(
		noise_texture.width * 0.5,
		noise_texture.height * 0.5
	)

	return centered_pos * world_scale

func _on_asteroid_split(at : Vector2) -> void:
	asteroid_positions.erase(at)

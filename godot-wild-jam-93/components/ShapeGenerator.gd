extends Node2D
class_name ShapeGenerator

@export var noise_texture : NoiseTexture2D
@export var threshold : float = 0.3
@export var max_shapes : int = 128
@export var world_scale : float = 2.0
@export var player : Player

var noise_image : Image

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
			GameManager.rng.randf_range(int(-noise_texture.height) / 2.0, int(noise_texture.height) / 2.0),
			GameManager.rng.randf_range(int(-noise_texture.height) / 2.0, int(noise_texture.height) / 2.0)
		)
		var value := sample_noise(local_pos)
		if value < threshold:
			continue

		var node := Node2D.new()
		add_child(node)
		node.draw.connect(_on_draw.bind(node))
		node.position = local_pos

func sample_noise(world_pos : Vector2) -> float:
	var x := int(round(world_pos.x / world_scale))
	var y := int(round(world_pos.y / world_scale))

	if x < 0:
		x += noise_texture.height
	if y < 0:
		y += noise_texture.width

	return noise_image.get_pixel(x, y).r

func _on_draw(node : Node2D) -> void:
	node.draw_circle(node.position, 64.0, Color.RED, true)

func _on_noise_texture_changed() -> void:
	pass

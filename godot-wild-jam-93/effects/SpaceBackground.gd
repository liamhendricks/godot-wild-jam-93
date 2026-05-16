extends TextureRect
class_name SpaceBackground

@export var scroll_strength : float = 1.0

var scroll_offset : Vector2
var player : Player

func init(_player : Player) -> void:
	player = _player

func _process(delta: float) -> void:
	material.set_shader_parameter(
		"mouse",
		player.position * 0.0001
	)

	position = player.position - (get_viewport_rect().size * 1.5) / 2

	scroll_offset += player.velocity * delta * scroll_strength
	material.set_shader_parameter("offset", scroll_offset)

extends TextureRect
class_name SpaceBackground

var player : Player

func init(_player : Player) -> void:
	player = _player

func _process(_delta: float) -> void:
	material.set_shader_parameter(
		"mouse",
		player.position * 0.0001
	)

	position = player.position - (get_viewport_rect().size * 1.5) / 2

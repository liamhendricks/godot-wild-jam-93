extends CanvasLayer

@onready var minimap : Minimap = $Minimap

func init(_player : Player, _shape_generator : ShapeGenerator) -> void:
	minimap.init(_player, _shape_generator)

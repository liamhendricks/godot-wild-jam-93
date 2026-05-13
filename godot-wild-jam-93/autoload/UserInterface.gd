extends CanvasLayer

@onready var minimap : Minimap = $Minimap

func init(_player : Player, _shape_generator : ShapeGenerator) -> void:
	minimap.init(_player, _shape_generator)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

extends CanvasLayer

@onready var minimap : Minimap = $Minimap
@onready var resource_label : Label = $Label

var player : Player

func _ready() -> void:
	SignalBus.resource_gathered.connect(_on_resource_gathered, Object.ConnectFlags.CONNECT_DEFERRED)

func init(_player : Player, _shape_generator : ShapeGenerator) -> void:
	player = _player
	minimap.init(_player, _shape_generator)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _on_resource_gathered(data : ResourceData) -> void:
	var key := "%d-%d" % [data.resource_type, data.resource_level]
	resource_label.text = "Ore collected: %s" % player.resource_collection_component.resources[key].resource_amount

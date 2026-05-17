extends Node2D

const bounty_level_increment : int = 1

@export var bounty : ResourceData
@export var bounty_increment_value_min : int = 5

var enter_timer = 10.0
var exit_timer = 10.0
var camera : Camera2D
var player: CharacterBody2D
var camera_zoom_in : Vector2 = Vector2(3,3)

func _ready() -> void:
	camera = get_parent().get_node("Camera2D")
	if !SignalBus.bounty_delivered.is_connected(_increment_bounty):
		SignalBus.bounty_delivered.connect(_increment_bounty)

func _increment_bounty(_data : ResourceData) -> void:
	bounty.resource_amount += GameManager.rng.randi_range(bounty_increment_value_min, bounty_increment_value_min + bounty_increment_value_min)
	bounty.resource_level += bounty_level_increment

func _physics_process(delta: float) -> void:
	if player != null:
		var dir = player.global_position - $Sprite2D/eyecircle.global_position
		$Sprite2D/eyecircle.rotation = dir.angle()
	if player != null and player.is_in_group("Hangar"):
		player.get_node("MovementComponent").speed = 0
		camera.zoom = camera.zoom.lerp(camera_zoom_in, delta * 1)
	else:
		
		pass

func _on_area_2d_body_entered(body: Player ) -> void:
	if body == player:
		
		player.position = position
		player.add_to_group("Hangar")
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player.remove_from_group("Hangar")
		player.get_node("MovementComponent").speed = 600

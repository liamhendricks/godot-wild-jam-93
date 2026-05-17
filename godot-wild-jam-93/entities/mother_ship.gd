extends Node2D

const bounty_level_increment : int = 1

@export var bounty : ResourceData
@export var bounty_increment_value_min : int = 5
@export var player : Player
@export var camera : Camera2D

@onready var eye : Node2D = $Eye
@onready var spawn_timer : Timer = $SpawnTimer
@onready var despawn_timer : Timer = $DespawnTimer

func _ready() -> void:
	if !SignalBus.bounty_delivered.is_connected(_increment_bounty):
		SignalBus.bounty_delivered.connect(_increment_bounty)

func _increment_bounty(_data : ResourceData) -> void:
	bounty.resource_amount += GameManager.rng.randi_range(bounty_increment_value_min, bounty_increment_value_min + bounty_increment_value_min)
	bounty.resource_level += bounty_level_increment

func _process(_delta: float) -> void:
	eye.look_at(player.global_position)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if !visible:
		return

	# do you have enough resource? if not, you die
	despawn_timer.stop()
	player.state_machine.transition("hanger")

func _on_spawn_timer_timeout() -> void:
	visible = true

func _on_despawn_timer_timeout() -> void:
	# kill the player with shooting star lazers
	pass # Replace with function body.

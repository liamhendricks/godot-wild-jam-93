extends Node2D

const bounty_level_increment : int = 1

@export var bounty : ResourceData
@export var bounty_increment_value_min : int = 5

var enter_timer = 10.0
var exit_timer = 10.0

func _ready() -> void:
	if !SignalBus.bounty_delivered.is_connected(_increment_bounty):
		SignalBus.bounty_delivered.connect(_increment_bounty)

func _increment_bounty(_data : ResourceData) -> void:
	bounty.resource_amount += GameManager.rng.randi_range(bounty_increment_value_min, bounty_increment_value_min + bounty_increment_value_min)
	bounty.resource_level += bounty_level_increment

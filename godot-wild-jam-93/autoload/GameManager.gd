extends Node

var rng : RandomNumberGenerator

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.seed = hash(Time.get_ticks_msec())

extends Node

func _ready() -> void:
	SignalBus.state_transition.connect(_signal_log.bind(SignalBus.state_transition.get_name()))
	SignalBus.resource_gathered.connect(_signal_log.bind(SignalBus.resource_gathered.get_name()))

func _signal_log(...args) -> void:
	if len(args) == 0:
		return

	var msg: String = "signal: %s emitted" % args[len(args)-1] 
	print(msg)

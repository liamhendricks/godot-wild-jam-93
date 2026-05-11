extends Node
class_name StateMachine

@export var states : Array[State]

var _states : Dictionary[String, State] = {}
var _current_state : State

func init(_player : Player) -> void:
	if len(states) == 0:
		return

	for state : State in states:
		state.player = _player
		state.machine = self
		state.init()
		_states[state.state_name] = state

	_current_state = states[0]
	_current_state.enter()

func transition(to : String) -> void:
	if to not in _states:
		return

	var from := _current_state
	_current_state.exit()
	_current_state = _states[to]
	_current_state.enter()

	SignalBus.state_transition.emit(from, _current_state)

func _physics_process(delta: float) -> void:
	if len(states) == 0 || _current_state == null:
		return

	_current_state.physics_process(delta)

func _process(delta: float) -> void:
	if len(states) == 0 || _current_state == null:
		return

	_current_state.process(delta)

extends Node

signal drill_started()
signal drill_stopped()
signal state_transition(from: State, to: State)
signal asteroid_split(at: Vector2)

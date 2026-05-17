extends Node

signal drill_started()
signal drill_stopped()
signal state_transition(from: State, to: State)
signal asteroid_split(at: Vector2)
signal bounty_delivered(data: ResourceData)
signal resource_gathered(data: ResourceData)
signal game_start()

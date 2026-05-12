extends State
class_name FlyState

func process(_delta:float) -> void:
	pass

func physics_process(_delta:float) -> void:
	if player.raycast.is_colliding():
		machine.transition("drill")
		return

func enter(_data : Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

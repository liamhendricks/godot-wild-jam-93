extends State
class_name FlyState

func process(_delta:float) -> void:
	pass

func physics_process(_delta:float) -> void:
	if player.raycast.is_colliding():
		machine.transition("drill")
		return

func enter(_data : Dictionary = {}) -> void:
	if player.animation.animation == "drilling" || player.animation.animation == "drill_transition":
		player.animation.stop()
		player.animation.play("hull_transition")

func exit() -> void:
	pass

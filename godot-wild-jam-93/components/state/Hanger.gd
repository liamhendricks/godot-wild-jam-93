extends State
class_name HangerState

@export var camera_zoom_in : Vector2 = Vector2(3,3)

func process(_delta:float) -> void:
	pass

func physics_process(_delta:float) -> void:
	pass

func enter(_data : Dictionary = {}) -> void:
	var tween := GameManager.provide_tween()
	tween.tween_property(player.camera, "zoom", camera_zoom_in, 2.0)

func exit() -> void:
	var tween := GameManager.provide_tween()
	tween.tween_property(player.camera, "zoom", Vector2(1.0, 1.0), 2.0)

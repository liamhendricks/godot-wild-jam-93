extends Control

var game_scene : PackedScene

func _ready() -> void:
	game_scene = load("res://main.tscn")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)

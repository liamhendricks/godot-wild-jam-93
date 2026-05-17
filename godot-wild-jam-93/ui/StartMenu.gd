extends Control

@onready var background = $SpaceBackground

var game_scene : PackedScene

func _ready() -> void:
	game_scene = load("res://main.tscn")
	background.size = get_viewport_rect().size * 1.5

func _on_start_button_pressed() -> void:
	SignalBus.game_start.emit()
	get_tree().change_scene_to_packed(game_scene)

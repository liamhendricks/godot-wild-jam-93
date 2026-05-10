extends Node2D

@onready var camera : Camera2D = $Camera2D
@export var shape_generator : ShapeGenerator
@onready var entity_streamer : EntityStreamer = $EntityStreamer
@onready var player : CharacterBody2D = $Player

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _physics_process(_delta: float) -> void:
	camera.position = player.position

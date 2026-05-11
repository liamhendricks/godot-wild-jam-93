extends Node2D

@onready var camera : Camera2D = $Camera2D
@onready var shape_generator : ShapeGenerator = $ShapeGenerator
@onready var player : CharacterBody2D = $Player
@onready var state_machine : StateMachine = $StateMachine

func _ready() -> void:
	state_machine.init(player)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _physics_process(_delta: float) -> void:
	camera.position = player.position

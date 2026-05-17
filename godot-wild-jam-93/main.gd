extends Node2D

@onready var camera : Camera2D = $Camera2D
@onready var shape_generator : ShapeGenerator = $ShapeGenerator
@onready var player : Player = $Player
@onready var state_machine : StateMachine = $StateMachine
@export var space_scene : PackedScene

var mother_ship = preload("res://entities/MotherShip.tscn")
var mother_arriving = null
var background : SpaceBackground

func _ready() -> void:
	UserInterface.resource_label.show()
	background = space_scene.instantiate()
	background.init(player)
	background.size = get_viewport_rect().size * 1.5
	add_child(background)
	state_machine.init(player)
	UserInterface.init(player, shape_generator)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _physics_process(_delta: float) -> void:
	camera.position = player.position
	

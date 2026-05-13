extends Node2D

@onready var camera : Camera2D = $Camera2D
@onready var shape_generator : ShapeGenerator = $ShapeGenerator
@onready var player : Player = $Player
@onready var state_machine : StateMachine = $StateMachine

@export var space_scene : PackedScene

var enter_timer = 10.0
var exit_timer = 20
var mother_ship = preload("res://entities/MotherShip.tscn")
var mother_arriving = null
var background : SpaceBackground

func _ready() -> void:
	background = space_scene.instantiate()
	background.init(player)
	background.size = get_viewport_rect().size * 1.5
	add_child(background)
	state_machine.init(player)
	UserInterface.init(player, shape_generator)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	camera.position = player.position

	enter_timer = enter_timer - delta
	exit_timer = exit_timer - delta
	if enter_timer <= 0:
		mother_arriving = mother_ship.instantiate()
		mother_arriving.position = player.position
		add_child(mother_arriving)#mother is here 
		enter_timer = 20.0
		exit_timer = 10
	if exit_timer <= 0:
		if mother_arriving != null:
			mother_arriving.queue_free()
			mother_arriving = null
		

	background.material.set_shader_parameter(
		"horizontalMovement",
		player.velocity.x * 0.01
	)

	background.material.set_shader_parameter(
		"verticalMovement",
		player.velocity.y * 0.01
	)


extends State
class_name DrillState

@export var drill_speed : float = 50.0
@export var drill_drag : float = 500.0
@export var drill_accel : float = 10.0
var drill_particles_scene :PackedScene = load("res://effects/DrillParticles.tscn")
var drill_particles : DrillParticles
var speed_tmp: float = 0.0
var drag_tmp: float = 0.0
var accel_tmp: float = 0.0

func init() -> void:
	drill_particles = drill_particles_scene.instantiate()
	player.add_child(drill_particles)
	drill_particles.position = player.raycast.target_position

func process(_delta:float) -> void:
	pass

func physics_process(_delta:float) -> void:
	if !player.raycast.is_colliding():
		machine.transition("fly")
		return

func enter() -> void:
	drill_particles.init(player.raycast.get_collision_normal() * 50.0)
	var velocity := player.velocity
	player.velocity = velocity / 2
	speed_tmp = player.movement_component.speed
	drag_tmp = player.movement_component.drag
	accel_tmp = player.movement_component.acceleration
	player.movement_component.speed = drill_speed
	player.movement_component.acceleration = drill_accel
	player.movement_component.drag = drill_drag

func exit() -> void:
	drill_particles.particles.emitting = false
	player.movement_component.speed = speed_tmp
	player.movement_component.drag = drag_tmp
	player.movement_component.acceleration = accel_tmp

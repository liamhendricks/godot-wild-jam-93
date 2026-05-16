extends State
class_name DrillState

const MAX_DRILL_BURST_VALUE : float = 1.0
const INITIAL_VELOCITY_MODIFIER : float = 3.0

@export var drill_speed : float = 50.0
@export var drill_drag : float = 500.0
@export var drill_accel : float = 10.0
@export var drill_speed_modifier : float = 2.0
@export var drill_particle_velocity_modifier : float = 50.0

var drill_particles_scene : PackedScene = load("res://effects/DrillParticles.tscn")
var drill_particles : DrillParticles
var asteroid : Asteroid

var speed_tmp: float = 0.0
var drag_tmp: float = 0.0
var accel_tmp: float = 0.0

var drill_burst_value : float = 0.0

func init() -> void:
	drill_particles = drill_particles_scene.instantiate()
	player.add_child(drill_particles)
	drill_particles.position = player.raycast.target_position

func process(delta : float) -> void:
	drill_burst_value = lerp(drill_burst_value, MAX_DRILL_BURST_VALUE, (delta * drill_speed_modifier))
	if drill_burst_value >= MAX_DRILL_BURST_VALUE - 0.01:
		machine.transition("burst", {"asteroid": asteroid})
		return

	if player.animation.is_playing():
		return

	if player.animation.animation != "drill_mode":
		player.animation.play("drill_mode")

func physics_process(_delta : float) -> void:
	if !player.raycast.is_colliding():
		machine.transition("fly")
		return

	# if we collide with a new asteroid while still in drill state, reset the asteroid
	if player.raycast.get_collider_rid() != asteroid.get_rid():
		enter()

func enter(_data : Dictionary = {}) -> void:
	AudioManager.play_audio("drill1", 2)

	player.animation.stop()
	player.animation.play("drill_transition")
	_set_asteroid()
	var velocity := player.raycast.target_position.normalized() * INITIAL_VELOCITY_MODIFIER
	player.velocity = velocity
	speed_tmp = player.movement_component.speed
	drag_tmp = player.movement_component.drag
	accel_tmp = player.movement_component.acceleration
	player.movement_component.speed = drill_speed
	player.movement_component.acceleration = drill_accel
	player.movement_component.drag = drill_drag

func exit() -> void:
	AudioManager.stop_audio("drill1", 2)	
	asteroid = null
	drill_particles.particles.emitting = false
	player.movement_component.speed = speed_tmp
	player.movement_component.drag = drag_tmp
	player.movement_component.acceleration = accel_tmp

func _set_asteroid() -> void:
	drill_burst_value = 0.0
	asteroid = player.raycast.get_collider()
	drill_particles.init(player.raycast.get_collision_normal() * drill_particle_velocity_modifier)

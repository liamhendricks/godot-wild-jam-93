extends State
class_name BurstState

@export var burst_accel_multiplier : float = 4.0
@export var burst_time : float = 2.0
@export var area_threshold : float = 1500.0

var asteroid_scene : PackedScene = load("res://entities/Asteroid.tscn")
var ore_scene : PackedScene = load("res://entities/Ore.tscn")

func process(_delta:float) -> void:
	pass

func physics_process(_delta:float) -> void:
	pass

func enter(data : Dictionary = {}) -> void:
	player.movement_component.acceleration *= burst_accel_multiplier
	if "asteroid" not in data:
		machine.transition("fly")
		return

	var asteroid : Asteroid = data["asteroid"]
	var ray_origin = player.raycast.global_position
	var hit_point = player.raycast.get_collision_point()
	var global_cut_dir = (hit_point - ray_origin).normalized().orthogonal()
	var local_cut_point = asteroid.to_local(hit_point)
	var local_cut_dir = global_cut_dir.rotated(-asteroid.global_rotation)
	var splits := asteroid.split_polygon(local_cut_dir, local_cut_point)

	if len(splits) == 2:
		handle_split(splits[0], true, asteroid.rotation)
		handle_split(splits[1], false, asteroid.rotation)

	SignalBus.asteroid_split.emit(asteroid.position_key)

	asteroid.queue_free()
	await GameManager.get_tree().create_timer(burst_time).timeout
	machine.transition("fly")

func exit() -> void:
	player.movement_component.acceleration /= burst_accel_multiplier

func handle_split(points : PackedVector2Array, right_side : bool, rot : float):
	var area := GameManager.get_polygon_area(points)
	if len(points) < 3 || area < area_threshold:
		var ore = ore_scene.instantiate() as Ore
		GameManager.add_child(ore)
		ore.rotation = rot
		if right_side:
			ore.global_position = player.right_spawn.global_position
		else:
			ore.global_position = player.left_spawn.global_position
	else:
		var a = asteroid_scene.instantiate() as Asteroid
		GameManager.add_child(a)
		a.set_points(points)
		a.rotation = rot
		if right_side:
			a.global_position = player.right_spawn.global_position
		else:
			a.global_position = player.left_spawn.global_position

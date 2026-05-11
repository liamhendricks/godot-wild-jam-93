extends Node2D
class_name DrillParticles

@onready var particles : GPUParticles2D = $GPUParticles2D

func init(dir: Vector2) -> void:
	particles.emitting = true
	particles.process_material.gravity = Vector3(dir.x, dir.y, 0.0)

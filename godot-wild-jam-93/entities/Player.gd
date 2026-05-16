extends CharacterBody2D
class_name Player

@export var movement_component : MovementComponent
@export var state_machine : StateMachine
@export var resource_collection_component : ResourceCollectionComponent
@export var inventory_component : InventoryComponent

@onready var raycast : RayCast2D = $RayCast2D
@onready var left_spawn : Node2D = $LeftSpawn
@onready var right_spawn : Node2D = $RightSpawn
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var thrusters : GPUParticles2D = $GPUParticles2D

func _process(_delta: float) -> void:
	if movement_component.dir == Vector2.ZERO:
		thrusters.emitting = false
	else:
		thrusters.emitting = true

	var velocity_ratio := velocity.length() / movement_component.speed
	velocity_ratio = clamp(velocity_ratio, 0.0, 1.0)

	thrusters.amount_ratio = velocity_ratio

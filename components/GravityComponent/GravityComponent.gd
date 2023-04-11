class_name GravityComponent extends Node

@export
var gravity: float = 15.0

func _ready():
	set_process(false)


func apply(velocity: Vector2, weight = 1.0):
	return Vector2(
		velocity.x,
		velocity.y + gravity * weight
	)

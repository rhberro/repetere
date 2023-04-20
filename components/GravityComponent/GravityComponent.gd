class_name GravityComponent extends Node

@export
var gravity: float = 10.0

func _ready():
	set_process(false)


func apply(velocity: Vector2, weight = 1.0):
	return Vector2(
		int(velocity.x),
		int(velocity.y + gravity * weight)
	)

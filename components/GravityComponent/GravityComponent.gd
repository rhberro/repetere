class_name GravityComponent

extends Node

@export
var gravity: float = 800.0

func _ready():
	set_process(false)


func apply(velocity: Vector2):
	return velocity.lerp(Vector2.DOWN * gravity, 0.10)

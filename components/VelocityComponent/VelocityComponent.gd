class_name VelocityComponent

extends Node

@export
var speed: float = 100.0

var velocity: Vector2 = Vector2.ZERO

func _ready():
	set_process(false)


func accelerate(to: Vector2):
	velocity = lerp(velocity, to.normalized() * speed, 0.15)


func decelerate():
	velocity = lerp(velocity, Vector2.ZERO, 0.10)

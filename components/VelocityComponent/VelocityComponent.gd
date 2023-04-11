class_name VelocityComponent extends Node

@export
var speed: float = 65.0

var velocity: Vector2 = Vector2.ZERO

func _ready():
	set_process(false)


func accelerate(to: Vector2, weight: float = 0.1):
	velocity.x = lerp(velocity.x, (to.normalized() * speed).x, weight)


func decelerate(weight: float = 0.1):
	velocity.x = lerp(velocity.x, 0.0, weight)

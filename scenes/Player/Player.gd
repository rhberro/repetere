class_name Player

extends CharacterBody2D

@onready
var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity_component.accelerate(direction)
	else:
		velocity_component.decelerate()

	velocity = velocity_component.velocity

	move_and_slide()

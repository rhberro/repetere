class_name Player

extends CharacterBody2D

@onready
var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent

@onready
var gravity_component: GravityComponent = $GravityComponent as GravityComponent

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	if direction:
		velocity_component.accelerate(direction)
	else:
		velocity_component.decelerate()

	velocity = gravity_component.apply(velocity_component.velocity)

	move_and_slide()

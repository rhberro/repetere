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

	# Apply gravity to the velocity component.
	if is_on_floor():
		velocity_component.velocity.y = 0
	else:
		velocity_component.velocity = gravity_component.apply(velocity_component.velocity, get_gravity_weight() )

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity_component.velocity.y = velocity_component.velocity.y - 130 # 4 Squares

	velocity = velocity_component.velocity

	move_and_slide()


func get_gravity_weight():
	if is_on_floor():
		return 0

	if Input.is_action_pressed("jump"): # Jumping
		if velocity.y < 0: # Going Up:
			return 0.3
	else:
		if velocity.y < 0: # Going Up:
			return 2 # Cut

	return 1

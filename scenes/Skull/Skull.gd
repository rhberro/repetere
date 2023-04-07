extends StaticBody2D

var initial_velocity: Vector2 = Vector2.ZERO

@onready
var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent

@onready
var gravity_component: GravityComponent = $GravityComponent as GravityComponent

func _ready():
	velocity_component.velocity = initial_velocity


func _physics_process(delta):
	velocity_component.decelerate()
	velocity_component.velocity = gravity_component.apply(velocity_component.velocity)

	move_and_collide(velocity_component.velocity * delta)

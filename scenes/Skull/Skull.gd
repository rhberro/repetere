extends StaticBody2D

@onready
var gravity_component: GravityComponent = $GravityComponent as GravityComponent

@onready
var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent

@onready
var health_component: HealthComponent = $HealthComponent as HealthComponent

@onready
var sprite: Sprite2D = $Sprite2D

var initial_velocity: Vector2 = Vector2.ZERO

func _ready():
	if velocity_component:
		velocity_component.velocity = initial_velocity

	if health_component:
		health_component._on_health_changed.connect(_on_health_changed)
		health_component._on_died.connect(_on_died)


func _on_health_changed(health: int, maximum_health: int):
	if sprite:
		sprite.region_rect = Rect2( (maximum_health - health) * 8, 0, 8, 8)


func _on_died():
	queue_free()


func _physics_process(delta):
	velocity_component.decelerate()
	velocity_component.velocity = gravity_component.apply(velocity_component.velocity)

	move_and_collide(velocity_component.velocity * delta)

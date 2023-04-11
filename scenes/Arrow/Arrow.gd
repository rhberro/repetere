extends Node2D

@onready
var velocity_component: VelocityComponent = $VelocityComponent

@onready
var hitbox_component: HitboxComponent = $HitboxComponent

func _ready():
	if (hitbox_component):
		hitbox_component.area_entered.connect(_on_area_entered)
		hitbox_component.body_entered.connect(_on_body_entered)


func _on_area_entered(area: Area2D):
	queue_free()


func _on_body_entered(body: TileMap):
	queue_free()


func _physics_process(delta):
	# Use VelocityComponent to accelerate to the right.
	velocity_component.accelerate(Vector2.RIGHT)

	# Should rotate to the arrow's direction.
	global_position = global_position + (velocity_component.velocity * delta).rotated(rotation)

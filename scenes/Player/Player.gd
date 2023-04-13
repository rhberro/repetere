class_name Player extends CharacterBody2D

var SkullScene: PackedScene = preload("res://scenes/Skull/Skull.tscn")

var initial_position: Vector2 = Vector2.ZERO

@onready
var sprite: Sprite2D = $Sprite2D

@onready
var animation_tree: AnimationTree = $AnimationTree

@onready
var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent

@onready
var gravity_component: GravityComponent = $GravityComponent as GravityComponent

@onready
var health_component: HealthComponent = $HealthComponent as HealthComponent

func _ready():
	initial_position = global_position

	if health_component:
		health_component._on_health_changed.connect(_on_health_changed)
		health_component._on_died.connect(_on_died)


func _on_health_changed(_health: int, _maximum_health: int):
	var skull_instance = SkullScene.instantiate()

	skull_instance.global_position = global_position
	skull_instance.initial_velocity = velocity_component.velocity

	global_position = initial_position

	# Should wait for the player positioning to avoid collisions.
	get_tree().current_scene.call_deferred("add_child", skull_instance)


func _on_died():
	get_tree().reload_current_scene()


func _physics_process(_delta):
	# Movement
	var direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	if direction:
		velocity_component.accelerate(direction)
	else:
		velocity_component.decelerate()

	# Gravity
	if is_on_floor():
		velocity_component.velocity.y = 0
	else:
		velocity_component.velocity = gravity_component.apply(velocity_component.velocity, _get_gravity_weight() )

	# Jumping
	var jumping = Input.is_action_just_pressed("jump")
	if is_on_floor():
		if jumping:
			velocity_component.velocity.y = velocity_component.velocity.y - 170

	# Apply
	velocity = velocity_component.velocity

	# Move
	move_and_slide()

	# Animate
	_do_animation()
	
	# Flip
	_do_flip()

func _get_gravity_weight():
	if is_on_floor():
		return 0

	if Input.is_action_pressed("jump"): # Jumping
		if velocity.y < 0: # Going Up:
			return 0.40
	else:
		if velocity.y < 0: # Going Up:
			return 2 # Cut

	return 1


func _do_animation():
	animation_tree.set("parameters/blend_position", velocity.normalized() )


func _do_flip():
	if velocity.x < 0:
		sprite.set_flip_h(true)
	elif velocity.x > 0:
		sprite.set_flip_h(false)

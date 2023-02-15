extends KinematicBody2D

class_name Player

# Movement
export var move_speed: float = 50.0

# Jumping & Gravity
export var jump_height: float = 35.0
export var jump_time_to_peak: float = 0.5
export var jump_time_to_ground: float = 0.4

onready var jump_velocity: float = ( ( 2.0 * jump_height ) / jump_time_to_peak ) * -1.0
onready var jump_gravity: float = ( -2.0 * jump_height ) / ( jump_time_to_peak * jump_time_to_peak ) * -1.0
onready var fall_gravity: float = ( -2.0 * jump_height ) / ( jump_time_to_ground * jump_time_to_ground ) * -1.0

var velocity = Vector2.ZERO

func _physics_process(delta):
  # Vertical
  velocity.y = velocity.y + get_gravity() * delta

  if Input.is_action_just_pressed("jump") and is_on_floor():
    # Particles
    _emit(5)

    velocity.y = jump_velocity

  # Horizontal
  var horizontal = Vector2.ZERO

  if Input.is_action_pressed("move_left"):
    horizontal.x = move_toward(horizontal.x, -200, move_speed)
  elif Input.is_action_pressed("move_right"):
    horizontal.x = move_toward(horizontal.x, 200, move_speed)
  else:
    horizontal.x = move_toward(horizontal.x, 0, 8)

  velocity.x = horizontal.x

  velocity = move_and_slide(velocity, Vector2.UP)

  # Animation
  _animate()

  # Flip & Look
  _look()

   # Particles
  _particles()

func get_gravity() -> float:
  return jump_gravity * get_gravity_modifier() if velocity.y < 0.0 else fall_gravity
  
func get_gravity_modifier() -> float:
  if is_on_floor():
    return 0.0
  elif Input.is_action_pressed("jump") or velocity.y > 0.0:
    return 1.0
  else:
    return 3.0

func _animate():
  if velocity.y > 0.0:
    $AnimatedSprite.play("FALLING")
  elif velocity.y < 0.0:
    $AnimatedSprite.play("JUMPING")
  elif velocity.x == 0.0:
    $AnimatedSprite.play("IDLE")
  else:
    $AnimatedSprite.play("WALKING")

func _look():
  if velocity.x < 0.0:
    $AnimatedSprite.flip_h = true
  if velocity.x > 0.0:
    $AnimatedSprite.flip_h = false

var Skull = preload("res://objects/skull/skull.tscn")

onready var initial_position = position

# Lives
signal lives_updated(lives, lives_max)

export var lives_max: int = 7

export var lives: int = lives_max

func _on_arrow_hit():
  # Skull
  var current_position = position
  var current_velocity = velocity

  var skull_instance = Skull.instance()

  skull_instance.position = current_position
  skull_instance.velocity = current_velocity
  skull_instance.direction = $AnimatedSprite.flip_h

  get_parent().add_child(skull_instance)

  # Damage
  _damage()

  velocity = Vector2.ZERO

# Coins
signal coins_updated(coins, coins_max)

export var coins_max: int = 5

export var coins: int = 0

func _on_pickup_coin():
  coins = coins + 1

  emit_signal("coins_updated", coins, lives_max)

  if coins == coins_max:
    _die()

func _damage():
  # Damage
  lives = lives - 1

  emit_signal("lives_updated", lives, lives_max)

  if lives == 0:
    _die()
  else:
    position = initial_position

func _die():
  return get_tree().reload_current_scene()

onready var on_floor: bool = is_on_floor()

var lowest: float = 0.0

func _particles():
  lowest = velocity.y if velocity.y > lowest else lowest

  if not on_floor and is_on_floor():
    _emit(lowest / 20.0)
    lowest = 0.0

  on_floor = is_on_floor()

var dust = preload("res://player/dust.tscn")

func _emit(amount: int = 10):
  var particles = dust.instance()
  particles.amount = amount
  add_child(particles)

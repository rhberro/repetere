extends KinematicBody2D

class_name Enemy

var direction = Vector2.LEFT

var velocity = Vector2.ZERO

export var move_speed: float = 20.0

onready var raycast_left: RayCast2D = $RayCast2DLeft

onready var raycast_right: RayCast2D = $RayCast2DRight

func _physics_process(delta):
  if is_on_wall() or not raycast_left.is_colliding() or not raycast_right.is_colliding():
    direction = direction * -1

  velocity = move_and_slide(direction * move_speed, Vector2.UP)

  # Animations
  _animate()

  # Looking
  _look()

func _animate():
  if velocity.x == 0.0:
    $AnimatedSprite.play("IDLE")
  else:
    $AnimatedSprite.play("WALKING")

func _look():
  if velocity.x < 0.0:
    $AnimatedSprite.flip_h = true
  if velocity.x > 0.0:
    $AnimatedSprite.flip_h = false

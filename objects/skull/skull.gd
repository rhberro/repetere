extends KinematicBody2D

export var gravity: float = 10.0

var velocity: Vector2

var direction: bool

func _ready():
  $AnimatedSprite.flip_h = direction

func _physics_process(delta):
  velocity.x = lerp(velocity.x, 0, 1 if is_on_floor() else 0.025)

  velocity.y = clamp(velocity.y + gravity if not is_on_floor() else 0, -300, 300)

  velocity = move_and_slide(velocity, Vector2.UP)

onready var animation = $AnimatedSprite

func _on_arrow_hit():
  _damage()

func _damage():
  if animation.animation == "default":
    animation.play("damaged")
  elif animation.animation == "damaged":
    animation.play("damaged_heavily")
  else:
    queue_free()

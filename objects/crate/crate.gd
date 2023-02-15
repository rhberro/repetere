extends StaticBody2D

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

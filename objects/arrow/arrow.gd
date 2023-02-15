extends KinematicBody2D

export var speed: float = 100.0

var velocity: Vector2 = Vector2(speed, 0)

onready var raycast: RayCast2D = $RayCast2D

func _physics_process(delta):
  velocity = move_and_slide(velocity)

  var collider = raycast.get_collider()

  if collider:
    queue_free()
  
    if collider.has_method('_on_arrow_hit'):
      collider._on_arrow_hit()

    _sound(collider)

func _sound(collider):
  if collider is Player:
    pass
  else:
    Mixer._play_arrow_hit_sound()

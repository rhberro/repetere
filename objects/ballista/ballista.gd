extends KinematicBody2D

onready var timer = $Timer

onready var animation = $AnimatedSprite

export var interval: float = 5.0

export var delay: float = 0.0

onready var started: bool = false if delay > 0.0 else true

func _ready():
  var interval = _get_interval()

  # First
  timer.start(interval)

func _on_timer_timeout():
  if not started:
    _start()
  elif animation.animation == 'empty':
    animation.play('loaded')
  elif animation.animation == 'loaded':
    _shoot()

func _start():
  started = true

  var interval = _get_interval()

  timer.stop()
  timer.start(interval)

func _get_interval():
  return delay if not started else interval / 2

onready var arrow = preload("res://objects/arrow/arrow.tscn")

func _shoot():
  var arrow_instance = arrow.instance()
  
  arrow_instance.position = position
  arrow_instance.rotation = rotation
  
  get_parent().add_child(arrow_instance)

  # Sound
  Mixer._play_arrow_shoot_sound()

  # Animation
  animation.play('empty')

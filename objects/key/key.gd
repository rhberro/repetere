extends Area2D

func _on_body_entered(body):
  if body is Player:
    queue_free()

    # Sound
    Mixer._play_pickup_coin_sound()

    if body.has_method('_on_pickup_key'):
      body._on_pickup_key()

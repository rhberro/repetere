extends Node

onready var pickup_coin_sound: AudioStreamPlayer = $pickup_coin

func _play_pickup_coin_sound():
  pickup_coin_sound.play()

onready var arrow_shoot_sound: AudioStreamPlayer = $arrow_shoot

func _play_arrow_shoot_sound():
  arrow_shoot_sound.play()

onready var arrow_hit_sound: AudioStreamPlayer = $arrow_hit

func _play_arrow_hit_sound():
  arrow_hit_sound.play()

extends Area2D

func _on_body_entered(body):
  var current_level = get_tree().current_scene.name

  if body is Player:
    if current_level == 'level_01':
      get_tree().change_scene("res://levels/level_02/level_02.tscn")
    elif current_level == 'level_02':
      get_tree().change_scene("res://levels/level_03/level_03.tscn")
    elif current_level == 'level_03':
      get_tree().change_scene("res://levels/level_04/level_04.tscn")
    elif current_level == 'level_04':
      get_tree().change_scene("res://levels/level_05/level_05.tscn")
    elif current_level == 'level_05':
      get_tree().quit()

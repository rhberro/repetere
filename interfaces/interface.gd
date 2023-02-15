extends Control

func _on_player_coins_updated(coins: int, _coins_max: int):
  var children = $container/coins_container.get_children()

  for index in len(children):
    var coin = children[index]

    if index < coins:
      coin._fill()
    else:
      coin._clear()

func _on_player_lives_updated(lives: int, _lives_max: int):
  var children = $container/hearts_container.get_children()

  for index in len(children):
    var heart = children[index]

    if index < lives:
      heart._fill()
    else:
      heart._clear()

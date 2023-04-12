class_name GoldCoin extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D):
	if body is Player:
		queue_free()

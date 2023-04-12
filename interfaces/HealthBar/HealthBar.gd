extends Control

@onready
var container: HBoxContainer = $MarginContainer/HBoxContainer

@onready
var player: Player = get_tree().get_first_node_in_group("Player") as Player

func _ready():
	if player:
		player.health_component._on_health_changed.connect(_on_health_changed)


func _on_health_changed(health: int, maximum_health: int):
	if not container:
		return

	for child in container.get_children():
		child.visible = child.get_index() < health

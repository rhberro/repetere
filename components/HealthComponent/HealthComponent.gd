class_name HealthComponent extends Node

@export
var health: int = 1

@export
var maximum_health: int = 1

signal _on_health_changed(health: int, maximum_health: int)

signal _on_died()

func _ready():
	set_process(false)


func take_damage(damage: int):
	# Died
	if health - damage == 0:
		_on_died.emit()

	health = health - damage

	_on_health_changed.emit(health, maximum_health)

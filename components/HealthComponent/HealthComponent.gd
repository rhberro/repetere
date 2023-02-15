extends Node2D

# class_name HealthComponent

export var maximum_health: int = 7

export var current_health: int = maximum_health

signal health_changed(health)

func _damage(amount: int) -> void:
  current_health = current_health - amount
  
  # Signal
  emit_signal("health_changed", current_health)

func _get_health() -> int:
  return current_health

func _get_maximum_health() -> int:
  return maximum_health

func _is_dead() -> bool:
  return not current_health

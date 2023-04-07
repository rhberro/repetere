class_name HitboxComponent extends Area2D

func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	if area is HurtboxComponent:
		if area.health_component: # Safety
			area.health_component.take_damage(1)

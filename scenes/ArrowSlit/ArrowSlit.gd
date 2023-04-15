extends StaticBody2D

@export
var delay: float = 0.0

@export
var wait_time: float = 4.0

@onready
var animation_player: AnimationPlayer = $AnimationPlayer

@onready
var timer: Timer = $Timer

var ArrowScene: PackedScene	= preload("res://scenes/Arrow/Arrow.tscn")

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = _get_delay_time()
	timer.start()


func _on_timer_timeout():
	timer.stop()

	if not animation_player.animation_finished.is_connected(_on_animation_finished):
		animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play("Load")


func _on_animation_finished(_animation_name: StringName):
	animation_player.stop()

	timer.wait_time = _get_wait_time()
	timer.start()

	var arrow_instance = ArrowScene.instantiate() as Node2D

	arrow_instance.global_position = global_position
	arrow_instance.rotation = rotation

	get_tree().current_scene.add_child(arrow_instance)


func _get_delay_time():
	return max(delay - animation_player.get_animation("Load").length, 0.5)


func _get_wait_time():
	return max(wait_time - animation_player.get_animation("Load").length, 0)

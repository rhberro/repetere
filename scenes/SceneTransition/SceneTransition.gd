extends CanvasLayer

@onready
var animation_player: AnimationPlayer = $AnimationPlayer

func change_scene_to_file(file: String):
	animation_player.play("Enter")

	await animation_player.animation_finished

	get_tree().change_scene_to_file(file)
	
	animation_player.play("Leave")

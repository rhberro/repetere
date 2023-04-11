extends Camera2D

@export
var target: Node2D = null

var viewport_width: float = ProjectSettings.get_setting('display/window/size/viewport_width')

var viewport_height: float = ProjectSettings.get_setting('display/window/size/viewport_height')

func _ready():
	set_offset(
		Vector2(
			viewport_width / 2,
			viewport_height / 2
		)
	)

func _process(_delta):
	if target == null:
		return

	var next = Vector2(
		floor(target.global_position.x / viewport_width) * viewport_width,
		floor(target.global_position.y / viewport_height) * viewport_height
	)

	global_position = global_position.lerp(next, 0.15)

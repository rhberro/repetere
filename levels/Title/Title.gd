extends Control

@onready
var button_play: Button = $MarginContainer/VBoxContainer/MarginContainer3/VBoxContainer/Button

@onready
var button_leave: Button = $MarginContainer/VBoxContainer/MarginContainer3/VBoxContainer/Button2

func _ready():
	if button_play:
		button_play.pressed.connect(_on_press_play)

	if button_leave:
		button_leave.pressed.connect(_on_press_leave)


func _on_press_play():
	SceneTransition.change_scene_to_file("res://levels/Level00/Level00.tscn")


func _on_press_leave():
	get_tree().quit()

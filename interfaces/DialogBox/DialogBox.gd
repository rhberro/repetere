extends Control

@onready
var label: Label = $MarginContainer/Panel/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Label

@onready
var animation_player: AnimationPlayer = $AnimationPlayer

@onready
var timer: Timer = $Timer

var text_to_show: String = ''

var completed: bool = false : get = _get_completed

signal _on_completed

func _get_completed():
	return text_to_show.length() and text_to_show.length() == label.text.length()


func _ready():
	set_visible(false)


func _set_label(text: String = ''):
	label.set_text(text)


func _get_label():
	return label.text


func _get_next() -> String:
	return text_to_show.substr(0, _get_label().length() + 1)


func display(message: String):
	# This resets the current label.
	_set_label()

	text_to_show = message

	set_visible(true)

	animation_player.animation_finished.connect(_on_show)
	animation_player.play("Show")

	get_tree().paused = true


func _on_show(_animation_name: StringName):
	timer.timeout.connect(_on_timeout)
	timer.wait_time = 0.03
	timer.start()


func _complete():
	timer.timeout.disconnect(_on_timeout)
	timer.stop()


func _on_timeout():
	_set_label(_get_next() )

	if completed:
		_complete()


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if completed:
			_hide()


func _hide():
	text_to_show = ''

	_set_label('')

	animation_player.animation_finished.connect(_on_hide)
	animation_player.play("Hide")

	get_tree().paused = false


func _on_hide(_animation_name: StringName):
	# Disconnects the callback
	animation_player.animation_finished.disconnect(_on_hide)

	set_visible(false)

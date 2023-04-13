extends Control

@onready
var timer: Timer = $Timer

@onready
var label: Label = $MarginContainer/Panel/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Label

var text_to_show: String = ''

var completed: bool = false : get = _get_completed

func _get_completed():
	return label.text.length() == text_to_show.length()


func _ready():
	set_visible(false)


func _show(message: String):
	text_to_show = message

	timer.timeout.connect(_on_timeout)
	timer.wait_time = 0.05
	timer.start()

	set_visible(true)


func _complete():
	timer.timeout.disconnect(_on_timeout)
	timer.stop()


func _hide():
	text_to_show = ''

	label.set_text('')

	timer.timeout.disconnect(_on_timeout)
	timer.stop()

	set_visible(false)


func _on_timeout():
	var text = text_to_show.substr(0, label.text.length() + 1)

	label.set_text(text)

	if completed:
		_complete()


func _process(delta):
	if completed:
		if Input.is_action_just_pressed("jump"):
			_hide()

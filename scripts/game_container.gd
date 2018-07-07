extends CanvasLayer


var mouse_pressed = false

func _ready():
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			mouse_pressed = event.pressed
	elif event is InputEventMouseMotion:
		if mouse_pressed:
			offset += event.relative

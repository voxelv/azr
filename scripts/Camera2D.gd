extends Camera2D

const zoom_speed = 0.05

var zoom_factor = 1.0
var mouse_pressed = false

func _input(event):
	if event is InputEventMouseMotion && mouse_pressed:
		offset.x -= event.relative.x * zoom_factor
		offset.y -= event.relative.y * zoom_factor

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MIDDLE:
			mouse_pressed = event.pressed
		elif event.button_index == BUTTON_WHEEL_UP:
			zoom_in()
		elif event.button_index == BUTTON_WHEEL_DOWN:
			zoom_out()

func zoom_in():
	zoom_at_mouse(-zoom_speed)
	
func zoom_out():
	zoom_at_mouse(zoom_speed)

func zoom_at_mouse(amount):
	var old_zoom = zoom_factor
	var zoom_at = get_local_mouse_position() - offset
	zoom_factor *= amount + 1.0
	var diff = 1.0 - (zoom_factor / old_zoom)
	
	offset.x += zoom_at.x * diff
	offset.y += zoom_at.y * diff
	
	zoom.x = zoom_factor
	zoom.y = zoom_factor
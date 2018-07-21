extends Camera2D

const zoom_speed = 0.05

onready var tm = $"../TileMap"

var zoom_factor = 1.0
var mouse_pressed = false

var zoom_set = [0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0]

var zoom_idx = zoom_set.find(1.0)

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
		elif event.button_index == BUTTON_LEFT && event.pressed:
			print(tm.world_to_map((event.position * zoom_factor) + offset))

func zoom_in():
	zoom_idx -= 1
	if zoom_idx < 0:
		zoom_idx = 0
	set_zoom_at_mouse(zoom_set[zoom_idx])

func zoom_out():
	zoom_idx += 1
	if zoom_idx > zoom_set.size() - 1:
		zoom_idx = zoom_set.size() - 1
	set_zoom_at_mouse(zoom_set[zoom_idx])

func set_zoom_at_mouse(set_zoom_to):
	var old_zoom = zoom_factor
	var zoom_at = get_local_mouse_position() - offset
	zoom_factor = set_zoom_to
	var diff = 1.0 - (zoom_factor / old_zoom)
	
	offset.x += zoom_at.x * diff
	offset.y += zoom_at.y * diff
	
	zoom.x = zoom_factor
	zoom.y = zoom_factor
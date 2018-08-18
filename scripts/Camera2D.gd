extends Camera2D

const zoom_speed = 0.05

onready var tm = $"../TileMap"

var zoom_factor = 1.0
var mouse_pressed = false
#var lmouse_pressed = false

var zoom_set = [0.125, 0.25, 0.5, 1.0]
var zoom_times = [8, 4, 2, 1]

var zoom_idx = zoom_set.find(1.0)

func _input(event):
	if event is InputEventMouseMotion && mouse_pressed:
		offset.x -= event.relative.x * zoom_factor
		offset.y -= event.relative.y * zoom_factor

#	elif event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT && event.pressed && not lmouse_pressed:
#			lmouse_pressed = true
#			print("click!")
#		if event.button_index == BUTTON_LEFT && not event.pressed && lmouse_pressed:
#			lmouse_pressed = false
#			print("unclick!")

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MIDDLE:
			mouse_pressed = event.pressed
		elif event.button_index == BUTTON_WHEEL_UP && !event.pressed:
			zoom_in()
		elif event.button_index == BUTTON_WHEEL_DOWN && !event.pressed:
			zoom_out()
		elif event.button_index == BUTTON_LEFT && event.pressed:
			var v = tm.world_to_map((event.position * zoom_factor) + offset)
			print(v)
			print(tm.get_cellv(v))

func zoom_in():
	zoom_idx -= 1
	if zoom_idx < 0:
		zoom_idx = 0
	set_zoom_at_mouse(zoom_set[zoom_idx])
	print(zoom_set[zoom_idx])

func zoom_out():
	zoom_idx += 1
	if zoom_idx > zoom_set.size() - 1:
		zoom_idx = zoom_set.size() - 1
	set_zoom_at_mouse(zoom_set[zoom_idx])
	print(zoom_set[zoom_idx])

func set_zoom_at_mouse(set_zoom_to):
	var old_zoom = zoom_factor
	var zoom_at = get_local_mouse_position() - offset
	zoom_factor = set_zoom_to
	var diff = 1.0 - (zoom_factor / old_zoom)
	
	offset.x += zoom_at.x * diff
	offset.y += zoom_at.y * diff
	
	zoom.x = zoom_factor
	zoom.y = zoom_factor

func _on_ResetViewButton_pressed():
	zoom.x = 1.0
	zoom.y = 1.0
	offset.x = 0
	offset.y = 0

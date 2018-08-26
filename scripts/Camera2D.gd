extends Camera2D

const zoom_speed = 0.05

onready var tm = $"../TileMap"
onready var game_glass = get_node("/root/main/top_ui_layer/HBoxContainer/VBoxContainer/game_glass")
onready var prev_ggc = game_glass.get_node("game_glass_center").get_rect().position

signal zoom_label_set

var zoom_factor = 1.0
var mouse_pressed = false

# Available Zoom Levels and the relative zoom (e.g. 2x)
var zoom_set =   [ 0.125, 0.25, 0.5, 1.0 ]
var zoom_times = [     8,    4,   2,   1 ]
var zoom_idx = zoom_set.find(1.0)  # Current zoom index

func _ready():
	set_zoom_label()
	get_tree().get_root().connect("size_changed", self, "_window_size_changed")

func set_zoom_label():
	emit_signal("zoom_label_set", zoom_times[zoom_idx])

func _input(event):
	if event is InputEventMouseMotion && mouse_pressed:
		offset.x -= event.relative.x * zoom_factor
		offset.y -= event.relative.y * zoom_factor

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
	set_zoom_label()

func zoom_out():
	zoom_idx += 1
	if zoom_idx > zoom_set.size() - 1:
		zoom_idx = zoom_set.size() - 1
	set_zoom_at_mouse(zoom_set[zoom_idx])
	print(zoom_set[zoom_idx])
	set_zoom_label()

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
	zoom_idx = zoom_set.find(1.0)
	zoom_factor = zoom_set[zoom_idx]
	zoom.x = 1.0
	zoom.y = 1.0
	offset.x = 0
	offset.y = 0
	set_zoom_label()
	
	var gg_center = (game_glass.rect_size / 2.0) + game_glass.rect_position
	var gg_center_ratio = gg_center / get_node("/root").size
	pass
	
func _window_size_changed():
	yield(get_tree(), "idle_frame")
	var ggc = game_glass.get_node("game_glass_center").rect_position
	var offset_by = Vector2((prev_ggc.x - ggc.x) * zoom.x, (prev_ggc.y - ggc.y) * zoom.y)
	print(offset_by)
	offset += offset_by
	prev_ggc = ggc
	

extends Node

onready var camera_target = $camera_target
onready var camera = $camera_target/Camera2D

var zoom_speed = 0.2

var mouse_pressed = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if event is InputEventMouseMotion:
		if mouse_pressed:
			camera_target.position -= event.relative

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			mouse_pressed = event.pressed
		elif event.button_index == BUTTON_WHEEL_UP:
			camera.zoom *= 1.0 - zoom_speed
		elif event.button_index == BUTTON_WHEEL_DOWN:
			camera.zoom *= 1.0 + zoom_speed
		print(camera.zoom)

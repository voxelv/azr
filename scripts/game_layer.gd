extends CanvasLayer

var zoom_speed = 0.2
var zoom_factor = 1.0

var mouse_pressed = false
var prev_offset

func _ready():
	prev_offset = offset
	pass

func _input(event):
	if event is InputEventMouseMotion:
		if mouse_pressed:
			offset += event.relative

func _unhandled_input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			mouse_pressed = event.pressed
			
#		elif event.button_index == BUTTON_WHEEL_UP:
#			var prev_pos = $origin.get_local_mouse_position()
##			print(prev_pos)
#
#			var zdiff = 1.0 + zoom_speed
#
#			var ofst = ((prev_pos * zdiff) - prev_pos) / zdiff
##			print(ofst)
#
#			scale.x += zoom_speed
#			scale.y += zoom_speed
#			print(scale)
#
##			offset -= ofst
#
#		elif event.button_index == BUTTON_WHEEL_DOWN:
#			var zdiff = 1.0 - zoom_speed
#
#			var ofstx = (zdiff * event.position.x) - event.position.x
#			var ofsty = (zdiff * event.position.y) - event.position.y
#
#			scale.x -= zoom_speed
#			scale.y -= zoom_speed
#			print(scale)


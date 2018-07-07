extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if $game_layer.mouse_pressed:
			$ui_layer.set_process_unhandled_input(false)
		else:
			$ui_layer.set_process_unhandled_input(true)

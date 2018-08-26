extends Node2D

var MOVE_DISTANCE = 17.0

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("move_cell_up"):
		print("move cell up")
		self.position.y -= MOVE_DISTANCE
	if Input.is_action_just_pressed("move_cell_down"):
		print("move cell down")
		self.position.y += MOVE_DISTANCE
	if Input.is_action_just_pressed("move_cell_left"):
		print("move cell left")
		self.position.x -= MOVE_DISTANCE
	if Input.is_action_just_pressed("move_cell_right"):
		print("move cell right")
		self.position.x += MOVE_DISTANCE

extends Control


onready var grid = $"../grid"


func _ready():
	pass


func _on_grid_resized():
	rect_size = grid.get_rect().size
	pass # replace with function body



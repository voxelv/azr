extends Node2D

const TILES_PER_SIDE = 25

onready var tilemap = get_node("TileMap")

func _ready():
	pass # Replace with function body.

func get_grid_rect():
	var side_length = tilemap.cell_size.x * TILES_PER_SIDE
	var rect = Rect2(position, Vector2(side_length, side_length))
	return(rect)

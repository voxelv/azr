extends Node2D

onready var tilemap = get_node("TileMap")

var grid_objects = {}

# easier indices
const X = 0
const Y = 1

func _ready():
	pass # Replace with function body.

func get_grid_rect():
	var side_length = tilemap.cell_size.x * utl.TILES_PER_SIDE
	var rect = Rect2(position, Vector2(side_length, side_length))
	return(rect)

func register_grid_object(grid_object):
	grid_object.grid = self
	grid_object.cellv = world_to_map(grid_object.position)
	grid_object.position = map_to_world(grid_object.cellv)
	grid_objects[grid_object.cellv] = grid_object
	
	var start_coord = grid_object.cellv
	tilemap.set_cellv(start_coord, utl.GRID_MULTI_CELL)
	for i in range(grid_object.width):
		for j in range(grid_object.height):
			var coord = [int(start_coord.x) + i, int(start_coord.y) + j]
			var prev_obj = tilemap.get_cell(coord[X], coord[Y])
			tilemap.set_cell(coord[X], coord[Y], utl.GRID_MULTI_CELL_SUBCELL)

func world_to_map(pos):
	var result = tilemap.world_to_map(pos)
	return result

func map_to_world(cellv):
	var result = tilemap.map_to_world(cellv)

func request_move(grid_object, direction):
	pass
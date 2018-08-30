extends Node2D

var type = utl.GRID_NONE

var grid = null
var cellv = null

export(int) var width = 1
export(int) var height = 1

func _ready():
	get_parent().register_grid_object(self)

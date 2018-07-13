extends Node

onready var grid = $grid

onready var slot_pre = preload("res://scenes/slot.tscn")

func _ready():
	for i in range(25*25):
		var slot = slot_pre.instance()
		slot.get_node("btn").connect("pressed", self, "_on_slot_pressed", [slot])
		grid.add_child(slot)
	pass

func _on_slot_pressed(slot):
	print(slot)
	pass

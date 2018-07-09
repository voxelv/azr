extends GridContainer

onready var slot_pre = preload("res://scenes/slot.tscn")

func _ready():
	for i in range(25*25):
		var slot = slot_pre.instance()
		add_child(slot)
	pass

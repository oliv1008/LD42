extends "Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(3, 3)
	state = 0
	type = types.ENTREPOT
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
var boostScale = [1000, 2000, 5000, 10000, 50000]

func specific_build():
	Global.addStock(boostScale[boostLevel - 1])
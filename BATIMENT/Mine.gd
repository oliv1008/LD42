extends "Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(3, 2)
	state = 0
	type = types.MINE
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
var boostScale = [10, 20, 40, 80, 160]

func specific_build():
	Main.addProduction(boostScale[boostLevel - 1])
extends "Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(3, 2)
	state = 0
	type = types.MINE
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
var boostScale = [10, 15, 20, 30, 60]

func specific_build():
	ressourcesProduction = boostScale[boostLevel - 1]
	Global.production += ressourcesProduction
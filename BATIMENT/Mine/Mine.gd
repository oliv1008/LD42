extends "../Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(3, 2)
	state = 0
	type = Global.MINE
	health = 60
	maxHealth = 60
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
var boostScale = [10, 15, 20, 25, 50]

func specific_build():
	ressourcesProduction = boostScale[boostLevel - 1]
	Global.production += ressourcesProduction
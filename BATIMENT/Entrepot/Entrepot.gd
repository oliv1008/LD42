extends "../Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(3, 3)
	state = 0
	type = Global.ENTREPOT
	health = 90
	maxHealth = 90
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
var boostScale = [100, 200, 500, 1000, 4000]

func specific_build():
	stock = boostScale[boostLevel - 1]
	Global.stock += stock
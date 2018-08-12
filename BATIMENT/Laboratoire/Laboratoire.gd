extends "../Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(1, 4)
	state = 0
	type = Global.LABORATOIRE
	health = 40
	maxHealth = 40
	pass
var boostScale = [1, 1.2, 1.5, 2, 3]
func specific_build():
	researchSpeed = boostScale[boostLevel - 1]
	Global.researchSpeed += researchSpeed
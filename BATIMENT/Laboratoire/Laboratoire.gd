extends "../Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(1, 4)
	state = 0
	type = Global.LABORATOIRE
	health = 40
	maxHealth = 40
		
var boostScale = [0.1, 0.2, 0.3, 0.4, 0.5]

func specific_build():
	researchSpeed = boostScale[boostLevel - 1]
	Global.researchSpeed += researchSpeed
	Global.isLabBuilt = true
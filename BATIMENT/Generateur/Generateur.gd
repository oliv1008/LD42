extends "../Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(4, 1)
	state = 0
	type = Global.GENERATEUR
	health = 40
	maxHealth = 40
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
var boostScale = [50, 60, 80, 90, 110]

func specific_build():
	energyProduction = boostScale[boostLevel - 1]
	Global.energy += energyProduction
	var new_popup = popup.instance()
	new_popup.initialize("Generateur", energyProduction)
	add_child(new_popup)
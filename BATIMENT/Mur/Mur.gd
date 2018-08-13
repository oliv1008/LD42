extends "../Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(1, 2)
	state = 0
	type = Global.MUR
	health = 600
	maxHealth = 600
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

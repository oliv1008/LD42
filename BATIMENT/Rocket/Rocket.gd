extends "../Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(3, 7)
	state = 0
	type = Global.ROCKET
	health = 1000
	maxHealth = 1000
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func specific_build():
	$AnimationPlayer.play("Rocket")
	$Sprite/Particles2D.visible = true
func animationEnd():
	Global.LaunchRocket()
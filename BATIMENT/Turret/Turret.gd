extends "../Batiment.gd"

func _ready():
	pos = Vector2(0, 0)
	size = Vector2(1, 1)
	state = 0
	type = Global.TURRET
	health = 20
	maxHealth = 20
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

var ennemies = []
var boostScale = [1.0, 1.5, 2.0, 3.0, 5.0]
const TURRET_SPEED = 3.0

func specific_build():
	attackSpeed = boostScale[boostLevel - 1]
	$Timer.wait_time = TURRET_SPEED / attackSpeed
	$Timer.start()
	
func _on_Area2D_body_entered(body):
	ennemies.append(body.get_parent())

func _on_Timer_timeout():
	if state == 1:
		attack()

func attack():
	if ennemies.size() != 0:
		if ennemies[0].get_node("KinematicBody2D") != null:
			ennemies[0].get_node("KinematicBody2D").queue_free()
			drawLaser(ennemies[0])
		ennemies.remove(0)

func drawLaser(body):
	$Laser.set_point_position(1, body.global_position - $Laser.global_position)
	$Laser.visible = true
	$AudioLaser.play()
	body.get_node("AnimationPlayer").play("Disparition Sprite Ennemies")
	$AnimationPlayer.play("Laser reset")
	
func resetLaser():
	$Laser.visible = false
	$Laser.set_point_position(1, Vector2(-20, -19.6))

	
func _on_Area2D_body_exited(body):
	var index = ennemies.find(body.get_parent())
	if index != -1:
		ennemies.remove(index)
extends Node2D

var corruptionLevel = 0

func _ready():
	$CorruptionProgress.wait_time = Global.CORRRUPTION_SPEED
	$CorruptionProgress.start()
	pass

func _on_Timer_timeout():
	CorruptionProgress()

var flag = [true, true, true]
var step = [50, 30, 15]
func _process(delta):
	var time_left = $MobWave.time_left
	for i in range(0, step.size()):
		if step[i] >= time_left and flag[i]:
			$CanvasLayer/Control/SEC/AnimationPlayer.play("TimeUntilNextWave")
			$CanvasLayer/Control/SEC/Label.text = str("NEXT WAVE IN ", step[i], " SECONDS !")
			flag[i] = false
			break

func CorruptionProgress():
	$LeftCorruption.rect_size += Vector2(Global.CELL_SIZE, 0)
	$RightCorruption.rect_size += Vector2(Global.CELL_SIZE, 0)
	$RightCorruption.rect_position -= Vector2(Global.CELL_SIZE, 0)
	for building in Global.Grid[corruptionLevel]:
		if building != null:
			building.corrupted()
	for building in Global.Grid[Global.GRID_LENGHT - corruptionLevel - 1]:
		if building != null:
			building.corrupted()
	corruptionLevel += 1
	Global.corruptionLevel = corruptionLevel

func _on_MobWave_timeout():
	$CanvasLayer/Control/SEC/AnimationPlayer.play("TimeUntilNextWave")
	$CanvasLayer/Control/SEC/Label.text = str("MONSTERS ARE COMMING !")
	for i in range(0, flag.size()):
		flag[i] = true
	new_mob_wave()

var ennemyScene = preload("res://ENNEMIES/Ennemies.tscn")
var ennemiesPerWaveSide = 5

func new_mob_wave():
	for i in range(0, ennemiesPerWaveSide):
		var ennemy = ennemyScene.instance()
		add_child(ennemy)
		ennemy.direction = pow(-1, randi() % 2 + 1)
		if ennemy.direction == 1:
			ennemy.position = Vector2(-210 - i*(64 + 32) + (randi() % 64 - 32), -40)
		else :
			ennemy.position = Vector2(6456 + i*(64 + 32) + (randi() % 64 - 32), -40)
			ennemy.scale.x = -1
			
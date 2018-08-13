extends Node2D

var corruptionLevel = 0
var triggerPesant = true
var valPesant = 25
var triggerHappy = true
var valHappy = 10
var waveTime = 100

var ennemyScene = preload("res://ENNEMIES/Ennemies.tscn")
var ennemiesPerWaveSide = 2

var corruption_speeds = [10, 12, 18, 23, 35]
var flag = [true, true, true]
var step = [60, 30, 15]

func _ready():
	$CorruptionProgress.wait_time = corruption_speeds[0]
	$MobWave.wait_time = waveTime
	$MobWave.start()
	$CorruptionProgress.start()
	pass

func _on_Timer_timeout():
	CorruptionProgress()

func _process(delta):
	var time_left = $MobWave.time_left
	for i in range(0, step.size()):
		if step[i] >= time_left and flag[i]:
			$CanvasLayer/Control/SEC/AnimationPlayer.play("TimeUntilNextWave")
			$CanvasLayer/Control/SEC/Label.text = str("NEXT WAVE IN ", step[i], " SECONDS !")
			flag[i] = false
			break
		

func CorruptionProgress():
	if corruptionLevel >= valPesant and triggerPesant:
		get_parent().get_node("AudioPesant").play()
		get_parent().get_node("AudioPesant").get_node("AnimationPlayer").play("FadeIn")
		triggerPesant = false
	elif corruptionLevel >= valHappy and triggerHappy:
		get_parent().get_node("AudioHappy").play()
		get_parent().get_node("AudioHappy").get_node("AnimationPlayer").play("FadeIn")
		triggerHappy = false
 
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
	if corruptionLevel > 10:
		$CorruptionProgress.wait_time = corruption_speeds[1]
	if corruptionLevel > 20:
		$CorruptionProgress.wait_time = corruption_speeds[2]
	if corruptionLevel > 25:
		$CorruptionProgress.wait_time = corruption_speeds[3]
	if corruptionLevel > 30:
		$CorruptionProgress.wait_time = corruption_speeds[4]

func _on_MobWave_timeout():
	$CanvasLayer/Control/SEC/AnimationPlayer.play("TimeUntilNextWave")
	$CanvasLayer/Control/SEC/Label.text = str("MONSTERS ARE COMMING !")
	for i in range(0, flag.size()):
		flag[i] = true
	new_mob_wave()

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
	ennemiesPerWaveSide	+= 10
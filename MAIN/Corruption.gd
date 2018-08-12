extends Node2D

var corruptionLevel = 0

func _ready():
	pass

func _on_Timer_timeout():
	CorruptionProgress()

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
	new_mob_wave()

var ennemyScene = preload("res://ENNEMIES/Ennemies.tscn")
var ennemiesPerWaveSide = 2

func new_mob_wave():
	for i in range(0, ennemiesPerWaveSide):
		var ennemy = ennemyScene.instance()
		add_child(ennemy)
		ennemy.direction = pow(-1, randi() % 2 + 1)
		if ennemy.direction == 1:
			ennemy.position = Vector2(-210, -40)
		else :
			ennemy.position = Vector2(6456, -40)
			ennemy.get_node("Sprite").flip_h = true
			
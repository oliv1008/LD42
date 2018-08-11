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
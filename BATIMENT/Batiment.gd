extends Node2D

var state = 0
#size = Longueur * hauteur
var size = Vector2(0, 0)
var pos = Vector2(0, 0)
var type = null
var boostLevel = 1

enum types {LABORATOIRE, MINE}

func _input(event):
	if state == 0 and event is InputEventMouseMotion:
		pos = get_global_mouse_position()
		if pos.x < 0:
			pos.x -= 64
		if pos.y > 0:
			pos.y += 64
		pos.x = int(pos.x / 64)
		pos.y = int(-pos.y / 64)
		position = Vector2(pos.x * 64 + 32, -pos.y * 64 - 32)
		if get_parent().isBuildable(self) :
			$Sprite.modulate = Color(0, 1, 0, 0.5)
		else :
			$Sprite.modulate = Color(1, 0, 0, 0.5)
	if event.is_action_pressed("ui_cancel"):
		queue_free()
		
	if state == 0 and event.is_action_pressed("PlacerBatiment") and Main.isBuildable(self):
		build()
	else :
		pass
			
func build():
	state = 1
	boostLevel = compute_boost()
	set_process_input(false)
	Main.add_building_grid(self)
	print(boostLevel)
	specific_build()

func compute_boost():
	var tempMax = 0
	for x in range(pos.x, pos.x + size.x):
		if pos.y > 0 and Main.Grid[x][pos.y - 1] != null and Main.Grid[x][pos.y - 1].type == type and Main.Grid[x][pos.y - 1].boostLevel > tempMax:
			tempMax = Main.Grid[x][pos.y - 1].boostLevel
	return boostLevel + tempMax

func specific_build():
	pass
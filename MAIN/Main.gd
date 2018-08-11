extends Node2D

var Grid = []

func _ready():
	init_grid()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func init_grid():
	for y in range(0,10):
		Grid.append([])
		for x in range(0,5):
			Grid[y].append(0)
	Grid[0][0] = 1
	Grid[3][0] = 2
	Grid[3][1] = 3
	print(Grid)

func _input(event):
	if event.is_action_pressed("Laboratoire"):
		var scene = preload("res://BATIMENT/Laboratoire.tscn")
		var node = scene.instance()
		add_child(node)

func isBuildable(var Batiment):
#	print("Batiment.pos = ", Batiment.pos)
#	if Batiment.pos.x >= 0 and Batiment.pos.x <= 9 and Batiment.pos.y >= 0 and Batiment.pos.y <= 4:
#		print("Grid = ", Grid[Batiment.pos.x][Batiment.pos.y])
	if Batiment.pos.y >= 1:
		return true
	else :
		return false

var ressources = 0
var production = 1
func _on_Timer_timeout():
	ressources += production
	print(ressources)

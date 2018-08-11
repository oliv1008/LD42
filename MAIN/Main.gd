extends Node2D

var Grid = []

func _ready():
	init_grid()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func init_grid():
	for x in range(0,10):
		Grid.append([])
		for y in range(0,5):
			Grid[x].append(0)
	print(Grid)

func _input(event):
	if event.is_action_pressed("Laboratoire"):
		var scene = preload("res://BATIMENT/Laboratoire.tscn")
		var node = scene.instance()
		add_child(node)

func isBuildable(var Batiment):

	if Batiment.pos.y >= 1:
		return true
	else :
		return false

var ressources = 0
var production = 1
func _on_Timer_timeout():
	ressources += production
	print(ressources)
		
func add_building_grid(building):
	for x in range(building.pos.x, building.pos.x + building.size.x):
		for y in range(building.pos.y, building.pos.y + building.size.y):
			Grid[x][y] = building
	print(Grid)

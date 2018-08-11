extends Node2D

var Grid = []
var labScene = preload("res://BATIMENT/Laboratoire.tscn")
var mineScene = preload("res://BATIMENT/Mine.tscn")

var ressources = 0
var production = 0
var stock = 100

func _ready():
	init_grid()

func _process(delta):
	print(production)
func init_grid():
	for x in range(0,100):
		Grid.append([])
		for y in range(0,100):
			Grid[x].append(null)

func _input(event):
	if event.is_action_pressed("Laboratoire"):
		initLab()
	elif event.is_action_pressed("Mine"):
		initMine()

func initLab():
	var node = labScene.instance()
	add_child(node)
	
func initMine():
	var node = mineScene.instance()
	add_child(node)
	
func isBuildable(var building):
	if building.pos.x < 0 or building.pos.x + building.size.x > 100\
	or building.pos.y < 0 or building.pos.y + building.size.y > 100:
		return false
	
	for x in range(building.pos.x, building.pos.x + building.size.x):
		for y in range(building.pos.y, building.pos.y + building.size.y):
			if Grid[x][y] != null:
				return false
	
	var underMe = 0
	for x in range(building.pos.x, building.pos.x + building.size.x):
		if Grid[x][building.pos.y - 1] != null or building.pos.y == 0:
			underMe += 1 
	if underMe == 0:
		return false
	return true

func add_building_grid(building):
	for x in range(building.pos.x, building.pos.x + building.size.x):
		for y in range(building.pos.y, building.pos.y + building.size.y):
			Grid[x][y] = building

func addProduction(add):
	production += add
	print(production)

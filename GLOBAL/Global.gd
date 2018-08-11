extends Node2D

var Grid = []

var Batiments = []
var BatimentsOff = []

var ressources = 50
var production = 0
var stock = 100
var energy = 100
var energyconsummed = 0
var researchSpeed = 0

var hauteurMaxDeConstruction = 5
var maxTourDePise = 1 

const GRID_LENGHT = 100
const GRID_HEIGH = 100
const CELL_SIZE = 64

const COST_LAB = 75
const COST_MINE = 50
const COST_ENTREPOT = 100
const COST_GENERATEUR = 75

const ENERGY_LAB = 80
const ENERGY_MINE = 40
const ENERGY_ENTREPOT = 10
const ENERGY_GENERATEUR = 0

var corruptionLevel = 0

func _ready():
	init_grid()

func init_grid():
	for x in range(0,GRID_LENGHT):
		Grid.append([])
		for y in range(0,GRID_HEIGH):
			Grid[x].append(null)

var labScene = preload("res://BATIMENT/Laboratoire.tscn")
var mineScene = preload("res://BATIMENT/Mine.tscn")
var entrepotScene = preload("res://BATIMENT/Entrepot.tscn")
var generateurScene = preload("res://BATIMENT/Generateur.tscn")
var Prices = {labScene:COST_LAB, mineScene:COST_MINE, entrepotScene:COST_ENTREPOT, generateurScene:COST_GENERATEUR}
var Energies = {labScene:ENERGY_LAB, mineScene:ENERGY_MINE, entrepotScene:ENERGY_ENTREPOT, generateurScene:ENERGY_GENERATEUR}
func _process(delta):
	if energyconsummed > energy:
		turnOffBuildings()
	elif BatimentsOff.size() > 0:
		turnOnBuildings()

func turnOffBuildings():
	var i = 0
	while energyconsummed > energy:
		Batiments[i].turnOff()
		BatimentsOff.append(Batiments[i])
		i += 1

func turnOnBuildings():
	var delta = energy - energyconsummed 
	for building in BatimentsOff:
		if building.Energies[building.type] < delta:
			building.turnOn()
			BatimentsOff.remove(BatimentsOff.find(building))

func _input(event):
	if event.is_action_pressed("Laboratoire"):
		initScene(labScene)
	elif event.is_action_pressed("Mine"):
		initScene(mineScene)
	elif event.is_action_pressed("Entrepot"):
		initScene(entrepotScene)
	elif event.is_action_pressed("Generateur"):
		initScene(generateurScene)

func initScene(scene):
	if ressources >= Prices[scene] && energy - energyconsummed >= Energies[scene] :
		var node = scene.instance()
		add_child(node)
	else:
		print("TROP CHER")

func isBuildable(var building):
	if building.pos.x < 0 + corruptionLevel or building.pos.x + building.size.x > GRID_LENGHT - corruptionLevel\
	or building.pos.y < 0  or building.pos.y + building.size.y > GRID_HEIGH:
		return false
	if building.pos.y >= hauteurMaxDeConstruction:
		print("TROP HAUT")
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
	if (building.size.x - underMe) > maxTourDePise:
		return false
	return true

func add_building_grid(building):
	for x in range(building.pos.x, building.pos.x + building.size.x):
		for y in range(building.pos.y, building.pos.y + building.size.y):
			Grid[x][y] = building

func addProduction(add):
	production = production + add

func addStock(add):
	stock += add

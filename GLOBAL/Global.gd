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

var isLabBuilt = false
var isRocketResearched = false
var hauteurMaxDeConstruction = 5
var maxTourDePise = 1 

const GRID_LENGHT = 100
const GRID_HEIGH = 100
const CELL_SIZE = 64

const COST_LAB = 1
const COST_MINE = 50
const COST_ENTREPOT = 1
const COST_GENERATEUR = 1
const COST_MUR = 50
const COST_TURRET = 1
const COST_ROCKET = 1

const ENERGY_LAB = 1
const ENERGY_MINE = 40
const ENERGY_ENTREPOT = 1
const ENERGY_GENERATEUR = 0
const ENERGY_MUR = 0
const ENERGY_TURRET = 10
const ENERGY_ROCKET = 0

var corruptionLevel = 0

func _ready():
	init_grid()

func init_grid():
	for x in range(0,GRID_LENGHT):
		Grid.append([])
		for y in range(0,GRID_HEIGH):
			Grid[x].append(null)

var labScene = preload("res://BATIMENT/Laboratoire/Laboratoire.tscn")
var mineScene = preload("res://BATIMENT/Mine/Mine.tscn")
var entrepotScene = preload("res://BATIMENT/Entrepot/Entrepot.tscn")
var generateurScene = preload("res://BATIMENT/Generateur/Generateur.tscn")
var murScene = preload("res://BATIMENT/Mur/Mur.tscn")
var noCurrentScene = preload("res://BATIMENT/NoCurrent.tscn")
var turretScene = preload("res://BATIMENT/Turret/Turret.tscn")
var rocketScene = preload("res://BATIMENT/Rocket/Rocket.tscn")


var Prices = {labScene:COST_LAB, mineScene:COST_MINE, entrepotScene:COST_ENTREPOT,\
		 generateurScene:COST_GENERATEUR, murScene:COST_MUR, turretScene:COST_TURRET, rocketScene:COST_ROCKET}
var Energies = {labScene:ENERGY_LAB, mineScene:ENERGY_MINE, entrepotScene:ENERGY_ENTREPOT, generateurScene:ENERGY_GENERATEUR\
		, murScene:ENERGY_MUR, turretScene:ENERGY_TURRET, rocketScene:ENERGY_ROCKET}
var labSceneSprites = [\
		preload("res://Assets/Pixel Art/Batiments/Labo/Labo.png"),\
		preload("res://Assets/Pixel Art/Batiments/Labo/Labo-lvl2.png"),\
		preload("res://Assets/Pixel Art/Batiments/Labo/Labo-lvl3.png"),\
		preload("res://Assets/Pixel Art/Batiments/Labo/Labo-lvl4.png"),\
		preload("res://Assets/Pixel Art/Batiments/Labo/Labo-lvl4.png"),]

var generatorSceneSprites = [\
		preload("res://Assets/Pixel Art/Batiments/Generator/Generator.png"),\
		preload("res://Assets/Pixel Art/Batiments/Generator/Generator-lvl2.png"),\
		preload("res://Assets/Pixel Art/Batiments/Generator/Generator-lvl3.png"),\
		preload("res://Assets/Pixel Art/Batiments/Generator/Generator-lvl4.png"),\
		preload("res://Assets/Pixel Art/Batiments/Generator/Generator-lvl5.png"),]

var mineSceneSprites = [\
		preload("res://Assets/Pixel Art/Batiments/Mine/Mine.png"),\
		preload("res://Assets/Pixel Art/Batiments/Mine/Mine-lvl2.png"),\
		preload("res://Assets/Pixel Art/Batiments/Mine/Mine-lvl3.png"),\
		preload("res://Assets/Pixel Art/Batiments/Mine/Mine-lvl4.png"),\
		preload("res://Assets/Pixel Art/Batiments/Mine/Mine-lvl5.png"),]

var turretSceneSprites = [\
		preload("res://Assets/Pixel Art/Batiments/Turret/Turret.png"),\
		preload("res://Assets/Pixel Art/Batiments/Turret/Turret-lvl2.png"),\
		preload("res://Assets/Pixel Art/Batiments/Turret/Turret-lvl3.png"),\
		preload("res://Assets/Pixel Art/Batiments/Turret/Turret-lvl4.png"),\
		preload("res://Assets/Pixel Art/Batiments/Turret/Turret-lvl5.png"),]

var entrepotSceneSprites = [\
		preload("res://Assets/Pixel Art/Batiments/Warehouse/Warehouse.png"),\
		preload("res://Assets/Pixel Art/Batiments/Warehouse/Warehouse-lvl2.png"),\
		preload("res://Assets/Pixel Art/Batiments/Warehouse/Warehouse-lvl3.png"),\
		preload("res://Assets/Pixel Art/Batiments/Warehouse/Warehouse-lvl4.png"),\
		preload("res://Assets/Pixel Art/Batiments/Warehouse/Warehouse-lvl5.png"),]

var murSceneSprites = [preload("res://Assets/Pixel Art/Batiments/Mur.png")]
var rocketSceneSprites = [preload("res://Assets/Pixel Art/Batiments/Rocket.png")]

enum types {LABORATOIRE, MINE, ENTREPOT, GENERATEUR, MUR, TURRET, ROCKET}
var Textures = {LABORATOIRE:labSceneSprites, GENERATEUR:generatorSceneSprites, MINE:mineSceneSprites,\
		TURRET:turretSceneSprites, ENTREPOT:entrepotSceneSprites, MUR:murSceneSprites, ROCKET:rocketSceneSprites}

var currentNode
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
	elif event.is_action_pressed("Mur"):
		initScene(murScene)
	elif event.is_action_pressed("Turret"):
		initScene(turretScene)
	elif event.is_action_pressed("Rocket"):
		initScene(rocketScene)

func initScene(scene):
	if ressources >= Prices[scene] && energy - energyconsummed >= Energies[scene] :
		if currentNode != null:
			currentNode.queue_free()
		var node = scene.instance()
		add_child(node)
		currentNode = node
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

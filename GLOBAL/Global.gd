extends Node2D

var Grid = []

var Batiments = []
var BatimentsOff = []

var ressources = 50
var production = 5
var stock = 100
var energy = 100
var energyconsummed = 0
var researchSpeed = 1

var isLabBuilt = false
var isRocketResearched = false
var hauteurMaxDeConstruction = 1
var maxTourDePise = 0

const GRID_LENGHT = 100
const GRID_HEIGH = 100
const CELL_SIZE = 64

const COST_LAB = 75
const COST_MINE = 50
const COST_ENTREPOT = 50
const COST_GENERATEUR = 25
const COST_MUR = 75
const COST_TURRET = 75
const COST_ROCKET = 150000

const ENERGY_LAB = 75
const ENERGY_MINE = 50
const ENERGY_ENTREPOT = 25
const ENERGY_GENERATEUR = 0
const ENERGY_MUR = 0
const ENERGY_TURRET = 25

const ENERGY_ROCKET = 0

var corruptionLevel = 0

func secToTime(sec):
	var seconds = int(sec) % 60
	var minutes = int(sec) / 60
	var strSeconds = str(seconds)
	if seconds < 10:
		strSeconds = strSeconds.insert(0, "0")
	var strMinutes = str(minutes)
	if minutes < 10:
		strMinutes = strMinutes.insert(0, "0")
	return str(strMinutes," : ",strSeconds)

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
		preload("res://Assets/Pixel Art/Batiments/Labo/Labo-lvl5.png"),]

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
		
var murSceneSprites = [\
		preload("res://Assets/Pixel Art/Batiments/Mur.png"),\
		preload("res://Assets/Pixel Art/Batiments/Mur.png"),\
		preload("res://Assets/Pixel Art/Batiments/Mur.png"),\
		preload("res://Assets/Pixel Art/Batiments/Mur.png"),\
		preload("res://Assets/Pixel Art/Batiments/Mur.png")]

var rocketSceneSprites = [preload("res://Assets/Pixel Art/Batiments/Rocket.png")]

enum types {LABORATOIRE, MINE, ENTREPOT, GENERATEUR, MUR, TURRET, ROCKET}
var Textures = {LABORATOIRE:labSceneSprites, GENERATEUR:generatorSceneSprites, MINE:mineSceneSprites,\
		TURRET:turretSceneSprites, ENTREPOT:entrepotSceneSprites, MUR:murSceneSprites, ROCKET:rocketSceneSprites}
var labNumber = 0
var currentNode
func _process(delta):
	if labNumber == 0:
		isLabBuilt = false
	if energyconsummed > energy:
		turnOffBuildings()
	elif BatimentsOff.size() > 0:
		turnOnBuildings()

func turnOffBuildings():
	var i = 0
	while energyconsummed > energy and i < Batiments.size():
		if Batiments[i].type != GENERATEUR:
			Batiments[i].turnOff()
			BatimentsOff.append(Batiments[i])
			Batiments.remove(i)
		i += 1

func turnOnBuildings():
	var delta = energy - energyconsummed 
	for building in BatimentsOff:
		if building.Energies[building.type] < delta:
			building.turnOn()
			Batiments.append(building)
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
	if ressources >= Prices[scene] && (energy - energyconsummed >= Energies[scene] or Energies[scene] <= 0) :
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

func restart_game():
	ressources = 50
	production = 5
	stock = 100
	energy = 100
	energyconsummed = 0
	researchSpeed = 1
	isLabBuilt = false
	isRocketResearched = false
	hauteurMaxDeConstruction = 1
	maxTourDePise = 0
	corruptionLevel = 0
	labNumber = 0
	Grid = []
	init_grid()
	for i in range(0, Batiments.size()):
		Batiments[i].queue_free()
	Batiments = []
	for i in range(0, BatimentsOff.size()):
		BatimentsOff[i].queue_free()
	BatimentsOff = []
	currentNode = null
	
func LaunchRocket():
	get_tree().change_scene("res://TUTO/VictoryScreen.tscn")

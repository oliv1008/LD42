extends Node2D

var state = 0
#size = Longueur * hauteur
var size = Vector2(0, 0)
var pos = Vector2(0, 0)
var type = null
var boostLevel = 1
var energyProduction = 0
var ressourcesProduction = 0
var stock = 0
var attackSpeed = 0
var researchSpeed = 0

enum types {LABORATOIRE, MINE, ENTREPOT, GENERATEUR, TOURELLE}
var Prices = {LABORATOIRE:Global.COST_LAB, MINE:Global.COST_MINE, ENTREPOT:Global.COST_ENTREPOT, GENERATEUR:Global.COST_GENERATEUR}
var Energies = {LABORATOIRE:Global.ENERGY_LAB, MINE:Global.ENERGY_MINE, ENTREPOT:Global.ENERGY_ENTREPOT, GENERATEUR:Global.ENERGY_GENERATEUR}
func _input(event):
	if state == 0 and event is InputEventMouseMotion:
		pos = get_global_mouse_position()
		if pos.x < 0:
			pos.x -= Global.CELL_SIZE
		if pos.y > 0:
			pos.y += Global.CELL_SIZE
		pos.x = int(pos.x / Global.CELL_SIZE)
		pos.y = int(-pos.y / Global.CELL_SIZE)
		position = Vector2(pos.x * Global.CELL_SIZE + Global.CELL_SIZE/2, -pos.y * Global.CELL_SIZE - Global.CELL_SIZE/2)
		if Global.isBuildable(self) :
			$Sprite.modulate = Color(0, 1, 0, 0.5)
		else :
			$Sprite.modulate = Color(1, 0, 0, 0.5)		
	elif state == 0 and event.is_action_pressed("PlacerBatiment") and Global.isBuildable(self):
		build()
	elif event.is_action_pressed("ui_cancel"):
		queue_free()

func build():
	state = 1
	$Sprite.modulate = Color(1, 1, 1, 1)	
	boostLevel = compute_boost()
	set_process_input(false)
	Global.Batiments.append(self)
	Global.add_building_grid(self)
	Global.ressources -= Prices[type]
	Global.energyconsummed += Energies[type]
	specific_build()

func compute_boost():
	var tempMax = 0
	for x in range(pos.x, pos.x + size.x):
		if pos.y > 0 and Global.Grid[x][pos.y - 1] != null and Global.Grid[x][pos.y - 1].type == type and Global.Grid[x][pos.y - 1].boostLevel > tempMax:
			tempMax = Global.Grid[x][pos.y - 1].boostLevel
	return boostLevel + tempMax

func turnOff():
	if type == MINE:
		Global.production -= ressourcesProduction
	elif type == LABORATOIRE:
		Global.researchSpeed -= researchSpeed
	elif type == ENTREPOT:
		Global.stock -= stock
	elif type == TOURELLE:
		Global.attackSpeed -= attackSpeed
	Global.energyconsummed -= Energies[type]
	$Sprite.modulate = Color(1, 0, 0, 0.5)
	
func turnOn():
	if type == MINE:
		Global.production += ressourcesProduction
	elif type == LABORATOIRE:
		Global.researchSpeed += researchSpeed
	elif type == ENTREPOT:
		Global.stock += stock
	elif type == TOURELLE:
		Global.attackSpeed += attackSpeed
	Global.energyconsummed += Energies[type]
	$Sprite.modulate = Color(1, 1, 1, 1)

func corrupted():
	smartRemove()

func smartRemove():
	turnOff()
	energyProduction = 0
	ressourcesProduction = 0
	stock = 0
	attackSpeed = 0
	researchSpeed = 0
	
	var index = Global.Batiments.find(self)
	if index != -1:
		Global.Batiments.remove(index)
	index = Global.BatimentsOff.find(self)
	if index != -1:
		Global.BatimentsOff.remove(index)
	for x in range (pos.x, pos.x + size.x):
		for y in range (pos.y, pos.y + size.y):
			Global.Grid[x][y] = null
	handleSuperiorBuildings()
	queue_free()
	print(Global.production)

func handleSuperiorBuildings():
	var nodesToCheck = []
	for x in range (pos.x, pos.x + size.x):
		if Global.Grid[x][pos.y + size.y + 1] != null:
			nodesToCheck.append(Global.Grid[x][pos.y + size.y + 1])
	for node in nodesToCheck:
		var underMe = 0
		for x in range (node.pos.x, node.pos.x + node.size.x):
			if node.pos.y - 1 >= 0 and Global.Grid[x][node.pos.y - 1] != null and Global.Grid[x][node.pos.y - 1] != self:
				underMe += 1
			if node.size.x - underMe > Global.maxTourDePise:
				node.smartRemove()
func specific_build():
	pass
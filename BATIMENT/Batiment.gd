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
var health
var maxHealth
var isOff = false
var pitch_scales = [1.0, 1.2, 1.4, 1.6, 2.0, 3.0]
var maxBoostLevel = 5

var Prices = {Global.LABORATOIRE:Global.COST_LAB, Global.MINE:Global.COST_MINE, Global.ENTREPOT:Global.COST_ENTREPOT,\
		 Global.GENERATEUR:Global.COST_GENERATEUR, Global.MUR:Global.COST_MUR, Global.TURRET:Global.COST_TURRET, Global.ROCKET:Global.COST_ROCKET}
var Energies = {Global.LABORATOIRE:Global.ENERGY_LAB, Global.MINE:Global.ENERGY_MINE,\
		Global.ENTREPOT:Global.ENERGY_ENTREPOT, Global.GENERATEUR:Global.ENERGY_GENERATEUR,\
		Global.MUR:Global.ENERGY_MUR, Global.TURRET:Global.ENERGY_TURRET, Global.ROCKET:Global.ENERGY_ROCKET}
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
	$Sprite.texture = Global.Textures[type][boostLevel - 1]
	set_process_input(false)
	Global.currentNode = null
	Global.Batiments.append(self)
	if type == Global.LABORATOIRE:
		Global.labNumber += 1
	Global.add_building_grid(self)
	Global.ressources -= Prices[type]
	Global.energyconsummed += Energies[type]
	$KinematicBody2D.set_collision_layer_bit(3, true)
	$KinematicBody2D.set_collision_mask_bit(3, true)
	
	$AudioStreamPlayer.pitch_scale = pitch_scales[boostLevel - 1]
	$AudioStreamPlayer.play()
	specific_build()

func compute_boost():
	var tempMax = 0
	for x in range(pos.x, pos.x + size.x):
		if pos.y > 0 and Global.Grid[x][pos.y - 1] != null and Global.Grid[x][pos.y - 1].type == type and Global.Grid[x][pos.y - 1].boostLevel > tempMax:
			tempMax = Global.Grid[x][pos.y - 1].boostLevel
	return clamp(boostLevel + tempMax, 0, maxBoostLevel)

func turnOff(outOfEnergy = true):
	if isOff == false:
		if type == Global.MINE:
			Global.production -= ressourcesProduction
		elif type == Global.LABORATOIRE:
			Global.researchSpeed -= researchSpeed
		elif type == Global.ENTREPOT:
			Global.stock -= stock
		elif type == Global.TURRET:
			state = 2
		Global.energyconsummed -= Energies[type]
	
		if outOfEnergy:
			add_child(Global.noCurrentScene.instance())
		$Sprite.modulate = Color(1, 0, 0, 0.5)
		isOff = true
		
		if type == Global.LABORATOIRE:
			Global.labNumber = clamp (Global.labNumber - 1, 0, 100000000)

func turnOn():
	isOff = false
	if type == Global.MINE:
		Global.production += ressourcesProduction
	elif type == Global.LABORATOIRE:
		Global.researchSpeed += researchSpeed
	elif type == Global.ENTREPOT:
		Global.stock += stock
	elif type == Global.TURRET:
		state = 1
	elif type == Global.GENERATEUR:
		Global.energy += energyProduction
	if type == Global.LABORATOIRE:
		Global.labNumber += 1
	Global.energyconsummed += Energies[type]
	$Sprite.modulate = Color(1, 1, 1, 1)
	if ($NoCurrent != null):
		$NoCurrent.queue_free()

func corrupted(): 
	smartRemove(false)

func smartRemove(outOfEnergy = false):
	print("REMOVE")
	turnOff(outOfEnergy)
	
	if type == Global.GENERATEUR:
		Global.energy -= energyProduction
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
	$AnimationPlayer.play("Disparition Sprite")
	$AudioDestruction.play()
	$KinematicBody2D.queue_free()

func endOfAnimation():
	queue_free()
	
func handleSuperiorBuildings():
	var nodesToCheck = []
	for x in range (pos.x, pos.x + size.x):
		if Global.Grid[x][pos.y + size.y] != null and nodesToCheck.find(Global.Grid[x][pos.y + size.y]) == -1:
			nodesToCheck.append(Global.Grid[x][pos.y + size.y])
	for node in nodesToCheck:
		var underMe = 0
		for x in range (node.pos.x, node.pos.x + node.size.x):
			print("SUPERIOR")
			if Global.Grid[x][node.pos.y - 1] != null and Global.Grid[x][node.pos.y - 1] != self:
				underMe += 1
		if node.size.x - underMe > Global.maxTourDePise or underMe == 0:
			node.smartRemove()

var lifeScene = preload("res://LIFEBAR/LifeBar.tscn")

func receiveAttack(dmg):
	health -= float(dmg)
	updateHealth()

func updateHealth():
	if health <= 0:
		smartRemove()
	else:
		updateLifeBar()
		
var isFullLife = true
func updateLifeBar():
	if isFullLife:
		isFullLife = false
		initLifeBar()
	$LifeBar.update(float(health), float(maxHealth))
	
func initLifeBar():
	var node = lifeScene.instance()
	add_child(node)
	
func specific_build():
	pass
extends Control

var TextureResearchIcon = { "Sky_is" : preload("res://Assets/Pixel Art/Icones/icone augmente limite tech.png"),\
							"Pisa" : preload("res://Assets/Pixel Art/Icones/icone leaning tower of pisa tech.png"),\
							"Rocket" : preload("res://Assets/Pixel Art/Icones/icone tech rocket.png")
}

var current_research

func _ready():
	$"BatimentsContainrer/Mine/CostContainer/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_MINE)
	$"BatimentsContainrer/Mine/CostContainer/MineraiContainer/- XXX".text = str("- ", Global.COST_MINE)
	$"BatimentsContainrer/Wall/CostContainer4/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_MUR)
	$"BatimentsContainrer/Wall/CostContainer4/MineraiContainer/- XXX".text = str("- ", Global.COST_MUR)
	$"BatimentsContainrer/Rocket/CostContainer6/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_ROCKET)
	$"BatimentsContainrer/Turret/CostContainer5/MineraiContainer/- XXX".text = str("- ", Global.COST_TURRET)
	$"BatimentsContainrer/Turret/CostContainer5/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_TURRET)
	$"BatimentsContainrer/Rocket/CostContainer6/MineraiContainer/- XXX".text = str("- ", Global.COST_ROCKET)
	$"BatimentsContainrer/Warehouse/CostContainer2/MineraiContainer/- XXX".text = str("- ", Global.COST_ENTREPOT)
	$"BatimentsContainrer/Warehouse/CostContainer2/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_ENTREPOT)
	$"BatimentsContainrer/Generator/CostContainer2/MineraiContainer/- XXX".text = str("- ", Global.COST_GENERATEUR)
	$"BatimentsContainrer/Laboratory/CostContainer3/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_LAB)
	$"BatimentsContainrer/Laboratory/CostContainer3/MineraiContainer/- XXX".text = str("- ", Global.COST_LAB)

func _process(delta):
	var ressources = Global.ressources
	var energy_available = Global.energy - Global.energyconsummed
	if ressources < Global.COST_MINE and energy_available < Global.ENERGY_MINE:
		$BatimentsContainrer/Mine.disabled = true
	else:
		$BatimentsContainrer/Mine.disabled = false
		
	if ressources < Global.COST_GENERATEUR and energy_available < Global.ENERGY_GENERATEUR:
		$BatimentsContainrer/Generator.disabled = true
	else:
		$BatimentsContainrer/Generator.disabled = false
	
	if ressources < Global.COST_ENTREPOT and energy_available < Global.ENERGY_ENTREPOT:
		$BatimentsContainrer/Warehouse.disabled = true
	else:
		$BatimentsContainrer/Warehouse.disabled = false
		
	if ressources < Global.COST_LAB and energy_available < Global.ENERGY_LAB:
		$BatimentsContainrer/Laboratory.disabled = true
	else:
		$BatimentsContainrer/Laboratory.disabled = false
		
	if ressources < Global.COST_MUR and energy_available < Global.ENERGY_MUR:
		$BatimentsContainrer/Wall.disabled = true
	else:
		$BatimentsContainrer/Wall.disabled = false
	
	if ressources < Global.COST_ROCKET and energy_available < Global.ENERGY_ROCKET:
		$BatimentsContainrer/Rocket.disabled = true
	else:
		$BatimentsContainrer/Rocket.disabled = false
	
	if ressources < Global.COST_TURRET and energy_available < Global.ENERGY_TURRET:
		$BatimentsContainrer/Turret.disabled = true
	else:
		$BatimentsContainrer/Turret.disabled = false

func _on_Laboratory_pressed():
	Global.initScene(Global.labScene)

func _on_Mine_pressed():
	Global.initScene(Global.mineScene)

func _on_Warehouse_pressed():
	Global.initScene(Global.entrepotScene)

func _on_Generator_pressed():
	Global.initScene(Global.generateurScene)

func _on_Wall_pressed():
	Global.initScene(Global.murScene)

func _on_Turret_pressed():
	Global.initScene(Global.turretScene)

func _on_Rocket_pressed():
	Global.initScene(Global.rocketScene)

func _on_ResearchButton_pressed():
	if $ResearchContainer.visible == false:
		$ResearchContainer.visible = true
	else:
		$ResearchContainer.visible = false

func _on_Upgrade_Limit_pressed():
#On check d'abord pour voir si le joueur peut lancer la recherche	
#A IMPLEMENTER
	current_research = "Sky_is"
	$IconResearch.texture = TextureResearchIcon.Sky_is
	$IconResearch.visible = true
	$ResearchContainer.visible = false
	$GlobalTimer.wait_time = 10
	$GlobalTimer.start()
	$ResearchAndLoadingContainer/LifeBar.visible = true
	$ResearchAndLoadingContainer/ResearchButton.visible = false
	$ResearchAndLoadingContainer/LifeBar.update(0, 100)
	$SecondTimer.start()

func _on_Pisa_pressed():
#On check d'abord pour voir si le joueur peut lancer la recherche	
#A IMPLEMENTER
	current_research = "Pisa"
	$IconResearch.texture = TextureResearchIcon.Pisa
	$IconResearch.visible = true
	$ResearchContainer.visible = false
	$GlobalTimer.wait_time = 10
	$GlobalTimer.start()
	$ResearchAndLoadingContainer/LifeBar.visible = true
	$ResearchAndLoadingContainer/ResearchButton.visible = false
	$ResearchAndLoadingContainer/LifeBar.update(0, 100)
	$SecondTimer.start()


func _on_Rocket_Research_pressed():
#On check d'abord pour voir si le joueur peut lancer la recherche	
#A IMPLEMENTER
	current_research = "Rocket"
	$IconResearch.texture = TextureResearchIcon.Rocket
	$IconResearch.visible = true
	$ResearchContainer.visible = false
	$GlobalTimer.wait_time = 10
	$GlobalTimer.start()
	$ResearchAndLoadingContainer/LifeBar.visible = true
	$ResearchAndLoadingContainer/ResearchButton.visible = false
	$ResearchAndLoadingContainer/LifeBar.update(0, 100)
	$SecondTimer.start()
	
func update_loading_bar():
	var time_passed = $GlobalTimer.wait_time - $GlobalTimer.time_left
	var health = time_passed * 100 / $GlobalTimer.wait_time
	$ResearchAndLoadingContainer/LifeBar.update(health, 100)
	
func on_research_over():
	$GlobalTimer.stop()
	$SecondTimer.stop()
	$IconResearch.visible = false
	$ResearchAndLoadingContainer/LifeBar.visible = false
	$ResearchAndLoadingContainer/ResearchButton.visible = true
	if current_research == "Sky_is":
		Global.hauteurMaxDeConstruction += 3
	if current_research == "Pisa":
		Global.maxTourDePise += 1
	if current_research == "Rocket":
		pass
extends Control

var TextureResearchIcon = { "Sky_is" : preload("res://Assets/Pixel Art/Icones/icone augmente limite tech.png"),\
							"Pisa" : preload("res://Assets/Pixel Art/Icones/icone leaning tower of pisa tech.png"),\
							"Rocket" : preload("res://Assets/Pixel Art/Icones/icone tech rocket.png")
}

var Ski_is_research_cost = [50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 500000]
var Ski_is_research_time = [10, 20, 30, 40, 50, 60, 120, 240, 480, 960]
var Sky_is_research_bonus = [2, 2, 3, 3, 4, 5, 5, 6, 15, 25]
var Ski_is_level = 0
const MAX_SKY_LEVEL = 9

var Pisa_research_cost = [50, 200, 1000, 4, 5, 6, 7, 8, 9, 10]
var Pisa_research_time = [30, 120, 480]
var Pisa_level = 0
const MAX_PISA_LEVEL = 3

var Rocket_research_cost = [100000]
var Rocket_research_time = [480]
var Rocket_level = 0
const MAX_ROCKET_LEVEL = 1

var current_research

func format_text_2(a):
	var strA = str(a)
	if a >= 10000:
		strA = str(a/1000, "K")
	return str(strA)

func _ready():
#-------INITIALISATION DES INFOS DES BATIMENTS SUR LES BOUTONS-------------------------------
	$"BatimentsContainrer/Mine/CostContainer/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_MINE)
	$"BatimentsContainrer/Mine/CostContainer/MineraiContainer/- XXX".text = str("- ", Global.COST_MINE)
	$"BatimentsContainrer/Wall/CostContainer4/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_MUR)
	$"BatimentsContainrer/Wall/CostContainer4/MineraiContainer/- XXX".text = str("- ", Global.COST_MUR)
	$"BatimentsContainrer/Rocket/CostContainer6/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_ROCKET)
	$"BatimentsContainrer/Turret/CostContainer5/MineraiContainer/- XXX".text = str("- ", format_text_2(Global.COST_TURRET))
	$"BatimentsContainrer/Turret/CostContainer5/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_TURRET)
	$"BatimentsContainrer/Rocket/CostContainer6/MineraiContainer/- XXX".text = str("- ", format_text_2(Global.COST_ROCKET))
	$"BatimentsContainrer/Warehouse/CostContainer2/MineraiContainer/- XXX".text = str("- ", Global.COST_ENTREPOT)
	$"BatimentsContainrer/Warehouse/CostContainer2/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_ENTREPOT)
	$"BatimentsContainrer/Generator/CostContainer2/MineraiContainer/- XXX".text = str("- ", Global.COST_GENERATEUR)
	$"BatimentsContainrer/Laboratory/CostContainer3/EnergieContainer/- XXX".text = str("- ", Global.ENERGY_LAB)
	$"BatimentsContainrer/Laboratory/CostContainer3/MineraiContainer/- XXX".text = str("- ", Global.COST_LAB)
#-------INITIALISATION DU TIMER POUR "Remaining Time"------------------------------

	var total_game_time = Global.GRID_LENGHT/2
	$RemainingTimer.wait_time = total_game_time
	$RemainingTimer.start()
	
func _process(delta):
	if Global.isLabBuilt == false:
		on_research_over(true)

	var ressources = Global.ressources
	var energy_available = Global.energy - Global.energyconsummed
#-----------TIMER----------------------------------------------
	var remaining_time = $RemainingTimer.time_left
	remaining_time = Global.secToTime(remaining_time)
	$TimerContainer/VBoxContainer/Time.text = remaining_time
#------------BATIMENTS--------------------------
	if ressources < Global.COST_MINE or energy_available < Global.ENERGY_MINE:
		$BatimentsContainrer/Mine.disabled = true
	else:
		$BatimentsContainrer/Mine.disabled = false
		
	if ressources < Global.COST_GENERATEUR or energy_available < Global.ENERGY_GENERATEUR:
		$BatimentsContainrer/Generator.disabled = true
	else:
		$BatimentsContainrer/Generator.disabled = false
	
	if ressources < Global.COST_ENTREPOT or energy_available < Global.ENERGY_ENTREPOT:
		$BatimentsContainrer/Warehouse.disabled = true
	else:
		$BatimentsContainrer/Warehouse.disabled = false
		
	if ressources < Global.COST_LAB or energy_available < Global.ENERGY_LAB:
		$BatimentsContainrer/Laboratory.disabled = true
	else:
		$BatimentsContainrer/Laboratory.disabled = false
		
	if ressources < Global.COST_MUR or energy_available < Global.ENERGY_MUR:
		$BatimentsContainrer/Wall.disabled = true
	else:
		$BatimentsContainrer/Wall.disabled = false
	
	if Global.isRocketResearched == false or ressources < Global.COST_ROCKET or energy_available < Global.ENERGY_ROCKET:
		$BatimentsContainrer/Rocket.disabled = true
	else:
		$BatimentsContainrer/Rocket.disabled = false
	
	if ressources < Global.COST_TURRET or energy_available < Global.ENERGY_TURRET:
		$BatimentsContainrer/Turret.disabled = true
	else:
		$BatimentsContainrer/Turret.disabled = false
		
	if Global.isLabBuilt == false:
		$ResearchAndLoadingContainer/ResearchButton.disabled = true
	else:
		$ResearchAndLoadingContainer/ResearchButton.disabled = false
#------------------------RECHERCHES--------------------------
	if $ResearchContainer.visible == true:
		
		if Ski_is_level >= MAX_SKY_LEVEL:
			$"ResearchContainer/Upgrade Limit".disabled = true
			$"ResearchContainer/Upgrade Limit/Container/TimeContainer/Time".visible = false
			$"ResearchContainer/Upgrade Limit/Container/TimeContainer/MineraiText".visible = false
			$"ResearchContainer/Upgrade Limit/Container/MineraiContainer2/- XXX".visible = false
			$"ResearchContainer/Upgrade Limit/Container/MineraiContainer2/MineraiText".visible = false
		else:
			var total_time = Ski_is_research_time[Ski_is_level] / Global.researchSpeed
			total_time = Global.secToTime(total_time)
			$"ResearchContainer/Upgrade Limit/Container/TimeContainer/Time".text = total_time
			$"ResearchContainer/Upgrade Limit/Container/MineraiContainer2/- XXX".text = format_text_2(Ski_is_research_cost[Ski_is_level])
			if ressources < Ski_is_research_cost[Ski_is_level]:
				$"ResearchContainer/Upgrade Limit".disabled = true
			else:
				$"ResearchContainer/Upgrade Limit".disabled = false
		
		if Pisa_level >= MAX_PISA_LEVEL:
			$ResearchContainer/Pisa.disabled = true
			$ResearchContainer/Pisa/Container2/TimeContainer/Time.visible = false
			$ResearchContainer/Pisa/Container2/TimeContainer/MineraiText.visible = false
			$"ResearchContainer/Pisa/Container2/MineraiContainer2/- XXX".visible = false
			$"ResearchContainer/Pisa/Container2/MineraiContainer2/MineraiText".visible = false
		else:
			var total_time = Pisa_research_time[Pisa_level] / Global.researchSpeed
			total_time = Global.secToTime(total_time)
			$ResearchContainer/Pisa/Container2/TimeContainer/Time.text = total_time
			$"ResearchContainer/Pisa/Container2/MineraiContainer2/- XXX".text = format_text_2(Pisa_research_cost[Pisa_level])
			if ressources < Pisa_research_cost[Pisa_level]:
				$ResearchContainer/Pisa.disabled = true
				
			else:
				$ResearchContainer/Pisa.disabled = false
		
		if Rocket_level >= MAX_ROCKET_LEVEL:
			$"ResearchContainer/Rocket Research".disabled = true
			$"ResearchContainer/Rocket Research/Container3/TimeContainer/Time".visible = false
			$"ResearchContainer/Rocket Research/Container3/TimeContainer/MineraiText".visible = false
			$"ResearchContainer/Rocket Research/Container3/MineraiContainer2/- XXX".visible = false
			$"ResearchContainer/Rocket Research/Container3/MineraiContainer2/MineraiText".visible = false
		else:
			var total_time = Rocket_research_time[Rocket_level] / Global.researchSpeed
			total_time = Global.secToTime(total_time)
			$"ResearchContainer/Rocket Research/Container3/TimeContainer/Time".text = total_time
			$"ResearchContainer/Rocket Research/Container3/MineraiContainer2/- XXX".text = format_text_2(Rocket_research_cost[Rocket_level])
			if Rocket_level >= 1 or ressources < Rocket_research_cost[Rocket_level]:
				$"ResearchContainer/Rocket Research".disabled = true
				
			else:
				$"ResearchContainer/Rocket Research".disabled = false

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
	var ressources = Global.ressources
	if ressources < Ski_is_research_cost[Ski_is_level] or Ski_is_level >= 9:
		pass
	else:
		current_research = "Sky_is"
		$IconResearch.texture = TextureResearchIcon.Sky_is
		$IconResearch.visible = true
		$ResearchContainer.visible = false
		var total_time = Ski_is_research_time[Ski_is_level] / Global.researchSpeed
		$GlobalTimer.wait_time = total_time
		$GlobalTimer.start()
		$ResearchAndLoadingContainer/LifeBar.visible = true
		$ResearchAndLoadingContainer/ResearchButton.visible = false
		$ResearchAndLoadingContainer/LifeBar.update(0, 100)
		$SecondTimer.start()

func _on_Pisa_pressed():
#On check d'abord pour voir si le joueur peut lancer la recherche	
	var ressources = Global.ressources
	if ressources < Pisa_research_cost[Pisa_level] or Pisa_level >= 9:
		pass
	else:
		current_research = "Pisa"
		$IconResearch.texture = TextureResearchIcon.Pisa
		$IconResearch.visible = true
		$ResearchContainer.visible = false
		var total_time = Pisa_research_time[Pisa_level] / Global.researchSpeed
		$GlobalTimer.wait_time = total_time
		$GlobalTimer.start()
		$ResearchAndLoadingContainer/LifeBar.visible = true
		$ResearchAndLoadingContainer/ResearchButton.visible = false
		$ResearchAndLoadingContainer/LifeBar.update(0, 100)
		$SecondTimer.start()	

func _on_Rocket_Research_pressed():
#On check d'abord pour voir si le joueur peut lancer la recherche	
#A IMPLEMENTER
	var ressources = Global.ressources
	if ressources < Rocket_research_cost[Rocket_level] or Rocket_level >= 1:
		pass
	else:
		current_research = "Rocket"
		$IconResearch.texture = TextureResearchIcon.Rocket
		$IconResearch.visible = true
		$ResearchContainer.visible = false
		var total_time = Rocket_research_time[Rocket_level] / Global.researchSpeed
		$GlobalTimer.wait_time = total_time
		$GlobalTimer.start()
		$ResearchAndLoadingContainer/LifeBar.visible = true
		$ResearchAndLoadingContainer/ResearchButton.visible = false
		$ResearchAndLoadingContainer/LifeBar.update(0, 100)
		$SecondTimer.start()
	
func update_loading_bar():
	var time_passed = $GlobalTimer.wait_time - $GlobalTimer.time_left
	var health = time_passed * 100 / $GlobalTimer.wait_time
	$ResearchAndLoadingContainer/LifeBar.update(health, 100)
	
func on_research_over(cancel = false):
	$GlobalTimer.stop()
	$SecondTimer.stop()
	$IconResearch.visible = false
	$ResearchAndLoadingContainer/LifeBar.visible = false
	$ResearchAndLoadingContainer/ResearchButton.visible = true
	if cancel == false:
		if current_research == "Sky_is":
			Global.hauteurMaxDeConstruction += Sky_is_research_bonus[Ski_is_level]
			Ski_is_level += 1
		if current_research == "Pisa":
			Global.maxTourDePise += 1
			Pisa_level += 1
		if current_research == "Rocket":
			Global.isRocketResearched = true
			Rocket_level += 1


func _on_Restart_pressed():
	Global.restart_game()
	get_tree().reload_current_scene()
	
func _on_Quit_pressed():
	get_tree().quit()

func _on_RemainingTimer_timeout():
	print("FIN DU JEU")

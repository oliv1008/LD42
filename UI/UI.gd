extends Control

var TextureResearchIcon = { "Sky_is" : preload("res://Assets/Pixel Art/Icones/icone augmente limite tech.png"),\
							"Pisa" : preload("res://Assets/Pixel Art/Icones/icone leaning tower of pisa tech.png"),\
							"Rocket" : preload("res://Assets/Pixel Art/Icones/icone tech rocket.png")
}

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
	pass # replace with function body


func _on_Rocket_Research_pressed():
	pass # replace with function body
	
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

func _on_TextureButton_pressed():
	print("COUCOU")
	get_tree().quit()

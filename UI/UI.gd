extends Control

func _on_Laboratory_pressed():
	Global.initScene(Global.labScene)

func _on_Mine_pressed():
	Global.initScene(Global.mineScene)

func _on_Warehouse_pressed():
	Global.initScene(Global.entrepotScene)

func _on_Generator_pressed():
	Global.initScene(Global.generateurScene)


func _on_ResearchButton_pressed():
	if $ResearchContainer.visible == false:
		$ResearchContainer.visible = true
	else:
		$ResearchContainer.visible = false

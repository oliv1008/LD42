extends Node2D

func _on_Timer_timeout():
	Global.ressources = clamp(Global.production + Global.ressources, 0, Global.stock)
	$CanvasLayer/UI/BatimentsContainrer/TextureRect/RessourcesContainer/MineralsContainer/Container/Text.text = str(Global.ressources, " / ", Global.stock)
	$CanvasLayer/UI/BatimentsContainrer/TextureRect/RessourcesContainer/EnergieContainer2/Container/Text.text = str(Global.energyconsummed, " / ", Global.energy)
	$CanvasLayer/UI/BatimentsContainrer/TextureRect/RessourcesContainer/ResearchContainer3/Container/Text.text = str(Global.researchSpeed)
	$CanvasLayer/UI/BatimentsContainrer/TextureRect/RessourcesContainer/ProductionContainer4/Container/Text.text = str(Global.production, " /s")

func _ready():
	$Line2D.set_point_position(0, Vector2(0, -64 * Global.hauteurMaxDeConstruction))
	$Line2D.set_point_position(1, Vector2(64*100, -64 * Global.hauteurMaxDeConstruction))

var oldHauteurMaxDeConstruction = 0
func _process(delta):
	if oldHauteurMaxDeConstruction != Global.hauteurMaxDeConstruction:
		updateLine()
		oldHauteurMaxDeConstruction = Global.hauteurMaxDeConstruction

func updateLine():
	$Line2D.set_point_position(0, Vector2(0, -Global.CELL_SIZE * Global.hauteurMaxDeConstruction))
	$Line2D.set_point_position(1, Vector2(Global.CELL_SIZE * Global.GRID_LENGHT, -Global.CELL_SIZE * Global.hauteurMaxDeConstruction))
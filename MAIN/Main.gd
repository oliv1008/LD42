extends Node2D

var police32 = preload("res://Assets/cave-story-32.tres")
var police24 = preload("res://Assets/cave-story-24.tres")

func _on_Timer_timeout():
	Global.ressources = clamp(Global.production + Global.ressources, 0, Global.stock)

	$CanvasLayer/UI/BatimentsContainrer/TextureRect/RessourcesContainer/MineralsContainer/Container/Text.text = format_text(Global.ressources, Global.stock)
	$CanvasLayer/UI/BatimentsContainrer/TextureRect/RessourcesContainer/EnergieContainer2/Container/Text.text = str(Global.energy - Global.energyconsummed)
	$CanvasLayer/UI/BatimentsContainrer/TextureRect/RessourcesContainer/ResearchContainer3/Container/Text.text = str(Global.researchSpeed)
	$CanvasLayer/UI/BatimentsContainrer/TextureRect/RessourcesContainer/ProductionContainer4/Container/Text.text = str(format_text_2(Global.production), " /s")

func format_text(a,b):
	var strA = str(a)
	var strB = str(b)
	if a >= 10000:
		strA = str(a/1000, "K")
	if b >= 10000:
		strB = str(b/1000, "K")
	return str(strA, " / ", strB)
func format_text_2(a):
	var strA = str(a)
	if a >= 10000:
		strA = str(a/1000, "K")
	return str(strA)
var oldHauteurMaxDeConstruction
func _ready():
	$Line2D.set_point_position(0, Vector2(-3000, -64 * Global.hauteurMaxDeConstruction))
	$Line2D.set_point_position(1, Vector2(64*100 + 3000, -64 * Global.hauteurMaxDeConstruction))
	oldHauteurMaxDeConstruction = Global.hauteurMaxDeConstruction
func _process(delta):
	if oldHauteurMaxDeConstruction != Global.hauteurMaxDeConstruction:
		updateLine()
		oldHauteurMaxDeConstruction = Global.hauteurMaxDeConstruction

func updateLine():
	$Line2D.set_point_position(0, Vector2(-3000, -Global.CELL_SIZE * Global.hauteurMaxDeConstruction))
	$Line2D.set_point_position(1, Vector2(3000 + Global.CELL_SIZE * Global.GRID_LENGHT, -Global.CELL_SIZE * Global.hauteurMaxDeConstruction))
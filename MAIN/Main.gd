extends Node2D

func _on_Timer_timeout():
	Global.ressources += Global.production
	$CanvasLayer/UI/BatimentsContainrer/RessourcesContainer/Minerai.text = str("Ressources :\n", Global.ressources, " / ", Global.stock)

func _ready():
	$Line2D.set_point_position(0, Vector2(0, -64 * Global.hauteurMaxDeConstruction))
	$Line2D.set_point_position(1, Vector2(64*100, -64 * Global.hauteurMaxDeConstruction))
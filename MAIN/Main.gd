extends Node2D

func _on_Timer_timeout():
	Global.ressources = clamp(Global.production + Global.ressources, 0, Global.stock)
	$CanvasLayer/UI/BatimentsContainrer/RessourcesContainer/Minerai.text = str("Ressources :\n", Global.ressources, " / ", Global.stock)
	$CanvasLayer/UI/BatimentsContainrer/RessourcesContainer/Energie.text = str("Energy :\n", Global.energyconsummed, " / ", Global.energy)

func _ready():
	$Line2D.set_point_position(0, Vector2(0, -64 * Global.hauteurMaxDeConstruction))
	$Line2D.set_point_position(1, Vector2(64*100, -64 * Global.hauteurMaxDeConstruction))
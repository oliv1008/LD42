extends Node2D

var main = null
var init = false

func _ready():
	if !init:
		init = true
		print("ici")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func init(main_arg):
	main = main_arg

func isBuildable(batiment):
	return main.isBuildable(batiment)
	
func add_building_grid(batiment):
	return main.add_building_grid(batiment)
	
func addProduction(boostScale):
	return main.addProduction(boostScale)
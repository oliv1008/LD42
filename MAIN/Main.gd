extends Node2D

var Grid = []

func _ready():
	init_grid()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func init_grid():
	for y in range(0,10):
		Grid.append([])
		for x in range(0,5):
			Grid[y].append(0)
	Grid[0][0] = 1
	Grid[3][0] = 2
	Grid[3][1] = 3
	print(Grid)

func _input(event):
	if event.is_action_pressed("Laboratoire"):
		var scene = preload("res://BATIMENT/Laboratoire.tscn")
		var node = scene.instance()
		add_child(node)
#	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed() :

func isBuildable(var Batiment):
	if Batiment.pos.y >= 2:
		return true
	else :
		return false
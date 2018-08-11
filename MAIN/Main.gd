extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var tab

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event.is_action_pressed("Laboratoire"):
		var scene = preload("res://BATIMENT//laboratoire.tscn")
		var node = scene.instance()
		add_child(node)	
#	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed() :

func isBuildable(var Batiment):
	if Batiment.pos.y >= 2:
		return true
	else :
		return false
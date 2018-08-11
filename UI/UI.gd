extends Control

var Laboratoire = preload("res://BATIMENT/Laboratoire.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Laboratory_pressed():
	var new_lab = Laboratoire.instance()
	Main.add_child(new_lab)

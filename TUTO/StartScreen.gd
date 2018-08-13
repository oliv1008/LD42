extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://TUTO/Tuto1.tscn")
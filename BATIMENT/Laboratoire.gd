extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var state = 0
var pos = Vector2(0, 0)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if state == 0 and event is InputEventMouseMotion:
		pos = get_global_mouse_position()
		pos.x = int(pos.x / 64)
		pos.y = int(-pos.y / 64)
		print(pos)
		position = Vector2(pos.x * 64 + 32 , -pos.y * 64 + 32)
		if get_parent().isBuildable(self) :
			print("OK")
		else :
			print("NOT OK")
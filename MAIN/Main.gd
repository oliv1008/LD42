extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event is InputEventMouseMotion:
		var pos = event.position
		pos.x = int(pos.x / 64)
		pos.y = int((get_viewport_rect().size.y - pos.y) / 64)
		print(pos)
		$TEST.position = Vector2(pos.x * 64 + 32 , get_viewport_rect().size.y - pos.y * 64 - 32)
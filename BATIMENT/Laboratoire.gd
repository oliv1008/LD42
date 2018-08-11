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

func _unhandled_input(event):
	if state == 0 and event is InputEventMouseMotion:
		pos = get_global_mouse_position()
		if pos.x < 0:
			pos.x -= 64
		if pos.y < 0:
			pos.y -= 64
		pos.x = int(pos.x / 64)
		pos.y = int(-pos.y / 64)
		print(pos)
		position = Vector2(pos.x * 64 + 32 , -pos.y * 64 + 32)
		if get_parent().isBuildable(self) :			
			$Sprite.modulate = Color(0, 1, 0, 0.5)
		else :
			pass
			$Sprite.modulate = Color(1, 0, 0, 0.5)
	if event.is_action_pressed("ui_cancel"):
		queue_free()
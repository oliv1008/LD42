extends Node2D

var speed = 200
var drag = false
var initPosCam = false
var initPosMouse = false
var initPosNode = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
#	var direction = Vector2()
#	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
#	direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
#	direction = direction.normalized()
#
#	var velocity = speed * direction * delta
#	position = position + velocity
	pass

func _input(event):
	if event.is_action_pressed("CameraSlide") :
#		var newTime = OS.get_ticks_msec()
#		var newPos = get_global_mouse_position()
#		var delta = newTime - oldTime
#		position += newPos - oldPos
#		oldTime = newTime
#		oldPos = newPos
#	else :
#		oldTime = OS.get_ticks_msec()
#		oldPos = get_global_mouse_position()
		
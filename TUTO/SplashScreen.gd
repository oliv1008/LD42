extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$AnimationPlayer.play("fade")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://TUTO/StartScreen.tscn")

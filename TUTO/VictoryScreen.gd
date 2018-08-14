extends Control

onready var tie = $TextInterfaceEngine
onready var tie2 = $TextInterfaceEngine2

func _ready():
	
	tie.buff_text("You managed to escape and save humanity !", 0.05)
	tie2.buff_text("Congratulations !!", 0.1)
	tie.set_state(tie.STATE_OUTPUT)
	tie2.set_state(tie2.STATE_OUTPUT)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().quit()

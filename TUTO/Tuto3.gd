extends Control

onready var tie = $TextInterfaceEngine
var show_next = 0

func _ready():
	# Connect every signal to check them using the "print()" method
	tie.connect("input_enter", self, "_on_input_enter")
	tie.connect("buff_end", self, "_on_buff_end")
	tie.connect("state_change", self, "_on_state_change")
	tie.connect("enter_break", self, "_on_enter_break")
	tie.connect("resume_break", self, "_on_resume_break")
	tie.connect("tag_buff", self, "_on_tag_buff")
	
	tie.buff_text("3 TECHNOLOGIES are available once you built\n your first laboratory:\n\n\n", 0.005)
	tie.buff_break()
	tie.buff_text("- \"SKY IS THE LIMIT\" will increase the height\n limit of construction (blue line) allowing you to\n stack more and more buildings on top of each\n other (max lvl : 10)\n\n", 0.005)
	tie.buff_break()
	tie.buff_text("- \"LEANING TOWER OF PISA\" let you build\n further on the\n side (max lvl : 3) \n\n", 0.005)
	tie.buff_break()
	tie.buff_text("- \"TO INFINITY AND BEYOND\" unlock\n the ROCKET (max lvl : 1)\n\n\n\n", 0.005)
	tie.buff_break()
	tie.buff_text(str("You will need to be fast. Therefore, shorcuts are available : 1,...,7 or azertyu/qwertyu or NUM_PAD1,...,NUM_PAD7.\n\n",\
			"Please save us from the mankind extinction ! Dying after so much effort for LD42 would piss me off ! Good Luck !"), 0.005)	
	tie.buff_break()
	tie.set_state(tie.STATE_OUTPUT)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_buff_end():
	print("Buff End")
	pass

func _on_state_change(i):
	print("New state: ", i)
	pass

func _on_enter_break():
	print("Enter Break")
	pass

func _on_resume_break():
	if show_next == 0:
		$Sky.visible = true
	elif show_next == 1:
		$Pisa.visible = true
	elif show_next == 2:
		$Rocket.visible = true
	elif show_next == 4:
		get_tree().change_scene("res://MAIN/Main.tscn")
	show_next += 1

func _on_tag_buff(s):
	print("Tag Buff ",s)
	pass
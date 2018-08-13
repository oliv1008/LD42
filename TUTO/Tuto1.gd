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
	
	tie.set_color(Color(1,1,1))
	tie.buff_text("Hello, I'm commander Jean-Francois, please excuse my English accent and spelling mistakes.\n\n\nLet me give you a quick recap of the situation :\n", 0.005)
	tie.buff_break()
	tie.buff_text("- CORRUPTION is spreading and MONSTERS are taking control over this planet !\n\n- We are \"running out of space\" and our world will be fully CORRUPTED in just a few minutes !\n\n", 0.005)
	tie.buff_break()
	tie.buff_text("- We need to build a ROCKET and escape this planet as fast as possible or humanity will be doomed forever !", 0.005)
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
		$HBoxContainer/VBoxContainer/TextureRect.visible = true
		$HBoxContainer/VBoxContainer/TextureRect2.visible = true
	elif show_next == 1:
		$HBoxContainer/VBoxContainer/TextureRect3.visible = true
	elif show_next == 2:
		print("ici")
		get_tree().change_scene("res://TUTO/Tuto2.tscn")
	show_next += 1

func _on_tag_buff(s):
	print("Tag Buff ",s)
	pass
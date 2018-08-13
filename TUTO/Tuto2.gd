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
	
	tie.buff_text("In order to build a ROCKET you will need MINERALS and TECHNOLOGIES. Several buildings will help you to complete this task :\n\n", 0.005)
	tie.buff_break()
	tie.buff_text("- MINES will produce more MINERALS\n", 0.005)
	tie.buff_break()
	tie.buff_text("- GENERATORS will produce the ENERGY needed for buildings to work\n", 0.005)
	tie.buff_break()
	tie.buff_text("- WAREHOUSES increases the total amount of MINERALS you can store\n", 0.005)
	tie.buff_break()
	tie.buff_text("- LABORATORIES will allow you to do RESEARCHES and unlock new TECHNOLOGIES. More LABORATORIES = Faster RESEARCH time\n", 0.005)
	tie.buff_break()
	tie.buff_text("- WALLS are very SOLID and will protect you temporarily from MONSTERS\n", 0.005)
	tie.buff_break()
	tie.buff_text("- TURRET are very FRAGILE but are able to kill MONSTERS\n\n\n", 0.005)
	tie.buff_break()
	tie.buff_text("Stacking buildings on top of one of the same kind will make them better and better : MINE produce more, TURRET shoot faster, ...", 0.005)	
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
		$BatimentContainer/Mine.visible = true
	elif show_next == 1:
		$BatimentContainer/Generator.visible = true
	elif show_next == 2:
		$BatimentContainer/Warehouse.visible = true
	elif show_next == 3:
		$BatimentContainer/Laboratory.visible = true
	elif show_next == 4:
		$BatimentContainer/Wall.visible = true
	elif show_next == 5:
		$BatimentContainer/Turret.visible = true
	elif show_next == 6:
		$empilement.visible = true
	elif show_next == 7:
		get_tree().change_scene("res://TUTO/Tuto3.tscn")
	show_next += 1

func _on_tag_buff(s):
	print("Tag Buff ",s)
	pass
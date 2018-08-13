extends CanvasLayer

var tie
var speed = 0.01
func _ready():
	tie = $Control/Container/Text
	
	tie.reset()
	tie.set_color(Color(1,1,1))
	# Buff text: "Text", duration (in seconds) of each letter
	tie.buff_text(str("Hello, I'm commander Jean-François, please excuse my English accent and spelling mistakes.\n",\
			"Let me give you a quick recap of the situation :\n",\
			"CORRUPTION is spreading and MONSTERS are taking control over this planet !\n",\
			"We are \"running out of space\" and our world will be fully CORRUPTED in just a few minutes !\n",\
			"We need to build a ROCKET and escape this planet as fast as possible or humanity will be doomed forever !\n\n"), 0.01)
	tie.buff_silence(0.5)
	tie.buff_text(str("In order to build a ROCKET you will need RESSOURCES and TECHNOLOGIES. Several buildings will help you to complete this task :\n",\
			"- MINES will produce more RESSOURCES\n",\
			"- GENERATORS will produce the ENERGY needed for buildings to work\n",\
			"- WAREHOUSES increases the total amount of RESSOURCES you can store\n",\
			"- LABORATORIES will allow you to do RESEARCHES and unlock new TECHNOLOGIES. More LABORATORIES = Faster RESEARCH time\n",\
			"- WALLS are very SOLID and will protect you temporarily from MONSTERS\n",\
			"- TURRET are very FRAGILE but are able to kill MONSTERS\n\n"), 0.01)	
	tie.buff_silence(0.5)
	tie.buff_text(str("Stacking buildings on top of one of the same kind will make them better and better : MINE produce more, TURRET shoot faster, ...\n\n",\
			"3 TECHNOLOGIES are available :\n",\
			"- \"SKY IS THE LIMIT\" will increase the height limit of construction (blue line) allowing you to stack more and more buildings on top of each other (max lvl : 10)\n",\
			"- \"LEANING TOWER OF PISA\" let you build further on the side (max lvl : 3) \n",\
			"- \"TO INFINITY AND BEYOND\" unlock the ROCKET (max lvl : 1)\n\n"), 0.01)
	tie.buff_silence(0.5)
	tie.buff_text(str("You will need to be fast. Therefore, shorcuts are available : 1,...,7 or azertyu or qwertyu or NUM_PAD1,...,NUM_PAD7.\n\n",\
			"Please save us from the mankind extinction ! Dying after so much effort for LD42 would piss me off !"), 0.01)	
	tie.set_state(tie.STATE_OUTPUT)

#
#
#Let me give you a quick recap of the situation :
#CORRUPTION is spreading and MONSTERS are taking control over this planet ! 
#We are "running out of space" and our world will be fully CORRUPTED in just a few minutes ! 
#We need to build a ROCKET and escape this planet as fast as possible or humanity will be doomed forever !
#
#In order to build a ROCKET you will need RESSOURCES and TECHNOLOGIES. Several buildings will help you to complete this task :
#- MINES will produce more RESSOURCES
#- GENERATORS will produce the ENERGY needed for buildings to work
#- WAREHOUSES increases the total amount of RESSOURCES you can store
#- LABORATORIES will allow you to do RESEARCHES and unlock new TECHNOLOGIES. More LABORATORIES = Faster RESEARCH time
#- WALLS are very SOLID and will protect you temporarily from MONSTERS
#- TURRET are very FRAGILE but are able to kill MONSTERS
#
#Stacking buildings on top of one of the same kind will make them better and better : MINE produce more, TURRET shoot faster, ...
#
#3 TECHNOLOGIES are available :
#- "SKY IS THE LIMIT" will increase the height limit of construction (blue line) allowing you to stack more and more buildings on top of each other (max lvl : 10)
#- "LEANING TOWER OF PISA" let you build further on the side (max lvl : 3) 
#- "TO INFINITY AND BEYOND" unlock the ROCKET (max lvl : 1)
#
#You will need to be fast. Therefore, shorcuts are available : 1,...,7 or azertyu or qwertyu or NUM_PAD1,...,NUM_PAD7.
#
#Please save us from the mankind extinction ! Dying after so much effort for LD42 would piss me off !
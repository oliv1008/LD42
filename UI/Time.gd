extends Label

var time
func _ready():
	time = Global.CORRRUPTION_SPEED * Global.GRID_LENGHT / 2
	$Timer.start()
	pass

func _on_Timer_timeout():
	time -=1
	var minutes = time / 60
	var secondes = time % 60
	var minutesStr = str(minutes)
	if minutes < 10:
		minutesStr = minutesStr.insert(0, "0")
	var secondesStr = str(secondes)
	if secondes < 10:
		secondesStr = secondesStr.insert(0, "0")
	text = str(minutesStr," : ", secondesStr)
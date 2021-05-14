extends Control

var pressed
var direction

func _ready():
	pressed = false

func _process(delta):
	if pressed and direction == 'left':
		Input.action_press("left") 
	elif pressed and direction == 'right':
		Input.action_press("right") 

func _on_Left_button_down():
	if !pressed:
		pressed = true
		direction = 'left'


func _on_Left_button_up():
	pressed = false
	direction = null
	Input.action_release("left")


func _on_Right_button_down():
	if !pressed:
		pressed = true
		direction = 'right'


func _on_Right_button_up():
	pressed = false
	direction = null
	Input.action_release("right")


func _on_buyWorker_pressed():
	var player = get_node("/root/Level/Player")
	player.buyWorker()


func _on_buildBuilding_pressed():
	var player = get_node("/root/Level/Player")
	if(player.population.worker > 0):
		var building = player.getPlayerBuilding()
		if(building.is_in_group("lvl1")):
			if(player.money > 2):
				player.loseMoney(3)
				building.runTimer()
		else:
			if(player.money > 0):
				player.loseMoney(1)
				building.runTimer()

extends Area2D

var buildButton
var player
var timerRunning
var buildingCost
var hp

func _ready():
	timerRunning = false
	buildButton = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/buildBuilding")
	player = get_node("/root/Level/Player")
	buildingCost = 5
	hp = 150

func showUI():
	buildButton.show()

func hideUI():
	buildButton.hide()

func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer") and $".".is_in_group("playerBuilding")):
		hideUI()


func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer") and $".".is_in_group("playerBuilding") and !timerRunning and (player.hallBuilded || $".".is_in_group("hall") and player.population.worker > 0)):
		showUI()

func runTimer():
	hideUI()
	$BuildTime.start()
	timerRunning = true

func _on_BuildTime_timeout():
	if($".".is_in_group("playerBuilding")):
		timerRunning = false
		homeBuilded()

func homeBuilded():
	if($".".is_in_group("home")):
		player.buildedHouse()
		var home = preload("res://Blueprints/Homes/HomeLvL2.tscn")
		var instance = home.instance()
		get_node('/root/Level').add_child(instance)
		instance.set_global_position(position)
		instance.add_to_group("lvl2")
		instance.add_to_group("homeReady")
		instance.z_index = -2
		$".".queue_free()

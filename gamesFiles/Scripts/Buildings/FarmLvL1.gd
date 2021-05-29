extends Area2D

var buildButton
var player
var timerRunning
var buildingCost
var hp
var buyFarmer

func _ready():
	timerRunning = false
	buildButton = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/buildBuilding")
	buyFarmer = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/BuyFarmer")
	player = get_node("/root/Level/Player")
	buildingCost = 10
	hp = 150

func showUI():
	buildButton.show()
	buyFarmer.show()

func hideUI():
	buildButton.hide()
	buyFarmer.hide()

func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer") and $".".is_in_group("playerBuilding")):
		hideUI()


func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer") and $".".is_in_group("playerBuilding") and !timerRunning and (player.hallBuilded || $".".is_in_group("hall"))):
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
	if($".".is_in_group("farm1")):
		var farm = preload("res://Blueprints/Farm/FarmLvL2.tscn")
		var instance = farm.instance()
		get_node('/root/Level').add_child(instance)
		instance.set_global_position(position)
		instance.add_to_group("lvl2")
		instance.add_to_group("farmReady")
		instance.z_index = -2
		$".".queue_free()


func _on_EarnTime_timeout():
	player.earnMoney(player.population.farmers)

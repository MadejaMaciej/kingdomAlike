extends Area2D

var buildButton
var player
var timerRunning
var buildingCost

func _ready():
	timerRunning = false
	buildButton = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/buildBuilding")
	player = get_node("/root/Level/Player")
	buildingCost = 1

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
		switchBuildings()

func switchBuildings():
	if($".".is_in_group("tent")):
		player.buildedTent()
		var tent = preload("res://Blueprints/Homes/HomeLvL1.tscn")
		var instance = tent.instance()
		get_node('/root/Level').add_child(instance)
		instance.set_global_position(position)
		instance.add_to_group("playerBuilding")
		instance.add_to_group("lvl1")
		instance.add_to_group("home")
		instance.z_index = -2
		$".".queue_free()
	elif($".".is_in_group("hall")):
		player.hallBuilded = true
		var hall = preload("res://Blueprints/Hall/HallLvL1.tscn")
		var instance = hall.instance()
		get_node('/root/Level').add_child(instance)
		instance.set_global_position(position)
		instance.add_to_group("playerBuilding")
		instance.add_to_group("lvl1")
		instance.add_to_group("hall")
		instance.z_index = -2
		$".".queue_free()
	elif($".".is_in_group("well")):
		var well = preload("res://Blueprints/Well/well.tscn")
		var instance = well.instance()
		get_node('/root/Level').add_child(instance)
		instance.set_global_position(position)
		instance.z_index = -2
		$".".queue_free()

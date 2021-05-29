extends Area2D

var buildButton
var player
var timerRunning
var buildingCost
var moneyStored
var hp
var maxPopDaily
var popDaily
var buttonBuy
var labelBuy

func _ready():
	timerRunning = false
	buildButton = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/buildBuilding")
	player = get_node("/root/Level/Player")
	buildingCost = 7
	moneyStored = 0
	hp = 400
	maxPopDaily = 5
	popDaily = 5
	buttonBuy = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/buyWorker")
	labelBuy = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/BuyWorkerText")

func showUI():
	buildButton.show()
	buttonBuy.show()
	prepareBuyLabel(popDaily)
	labelBuy.show()

func hideUI():
	buildButton.hide()
	buttonBuy.hide()
	labelBuy.hide()

func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer") and $".".is_in_group("playerBuilding")):
		hideUI()


func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer") and $".".is_in_group("playerBuilding") and !timerRunning and (player.hallBuilded || $".".is_in_group("hall"))):
		showUI()
		player.setCoins(moneyStored)
		moneyStored = 0

func runTimer():
	hideUI()
	$BuildTime.start()
	timerRunning = true
	moneyStored = 0
	$GenMoney.stop()

func _on_BuildTime_timeout():
	if($".".is_in_group("playerBuilding")):
		timerRunning = false
		hallBuilded()

func hallBuilded():
	if($".".is_in_group("hall")):
		var home = preload("res://Blueprints/Hall/HallLvL2.tscn")
		var instance = home.instance()
		get_node('/root/Level').add_child(instance)
		instance.set_global_position(position)
		instance.add_to_group("lvl2")
		instance.add_to_group("hallReady")
		instance.z_index = -2
		$".".queue_free()


func _on_GenMoney_timeout():
	randomize()
	popDaily = randi()%maxPopDaily+1
	prepareBuyLabel(popDaily)

func prepareBuyLabel(p):
	var text = "People: "
	text += str(p)
	labelBuy.text = text

func getPeople():
	return popDaily

func buyWorker():
	if(popDaily > 0):
		popDaily -= 1
		prepareBuyLabel(popDaily)


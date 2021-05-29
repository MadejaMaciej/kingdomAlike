extends Area2D

var buildButton
var player
var timerRunning
var buildingCost
var hp
var buyFarmer

func _ready():
	player = get_node("/root/Level/Player")
	buyFarmer = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/BuyFarmer")

func showUI():
	buyFarmer.show()

func hideUI():
	buyFarmer.hide()

func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer")):
		hideUI()


func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer")):
		showUI()

func _on_EarnTime_timeout():
	player.earnMoney(player.population.farmers * 2)

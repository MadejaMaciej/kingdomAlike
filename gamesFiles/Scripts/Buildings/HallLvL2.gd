extends Area2D

var moneyStored
var player
var hp
var maxPopDaily
var popDaily
var buttonBuy
var labelBuy

func _ready():
	moneyStored = 0
	player = get_node("/root/Level/Player")
	hp = 1000
	maxPopDaily = 7
	popDaily = 10
	buttonBuy = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/buyWorker")
	labelBuy = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/BuyWorkerText")
	

func _on_GenMoney_timeout():
	randomize()
	popDaily = randi()%maxPopDaily+3
	prepareBuyLabel(popDaily)

func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer")):
		player.setCoins(moneyStored)
		moneyStored = 0
		showUI()

func prepareBuyLabel(p):
	var text = "People: "
	text += str(p)
	labelBuy.text = text

func showUI():
	buttonBuy.show()
	prepareBuyLabel(popDaily)
	labelBuy.show()

func hideUI():
	buttonBuy.hide()
	labelBuy.hide()


func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer")):
		hideUI()

func getPeople():
	return popDaily

func buyWorker():
	if(popDaily > 0):
		popDaily -= 1
		prepareBuyLabel(popDaily)


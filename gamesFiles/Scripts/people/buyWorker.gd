extends Area2D

var people
var maxPeople
var buttonBuy
var labelBuy

func _ready():
	maxPeople = 10
	people = 10
	buttonBuy = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/buyWorker")
	labelBuy = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/BuyWorkerText")

func _on_Timer_timeout():
	if(people + 1 <= maxPeople):
		people += 1

func prepareBuyLabel(p):
	var text = "People: "
	text += str(p)
	labelBuy.text = text

func showUI():
	buttonBuy.show()
	prepareBuyLabel(people)
	labelBuy.show()

func hideUI():
	buttonBuy.hide()
	labelBuy.hide()

func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer")):
		showUI()

func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer")):
		hideUI()

func getPeople():
	return people

func buyWorker():
	if(people > 0):
		people -= 1
		prepareBuyLabel(people)
		var zombieScene = preload("res://Blueprints/Enemies/Zombies/Zombie1.tscn")
		var instance = zombieScene.instance()
		add_child(instance)

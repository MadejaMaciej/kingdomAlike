extends Area2D

var moneyStored
var player
var hp

func _ready():
	moneyStored = 0
	player = get_node("/root/Level/Player")
	hp = 1000

func _on_GenMoney_timeout():
	moneyStored += player.population.worker

func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer")):
		player.setCoins(moneyStored)
		moneyStored = 0

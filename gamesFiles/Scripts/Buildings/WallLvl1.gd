extends Area2D

var buildButton
var player
var timerRunning
var buildingCost
var hp
var wallDmg

func _ready():
	timerRunning = false
	buildButton = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/buildBuilding")
	player = get_node("/root/Level/Player")
	buildingCost = 10
	hp = 50
	player.wallBuilded(self)
	wallDmg = 10
	updateWallDMG()

func updateWallDMG():
	wallDmg = player.population.sword * player.soliderStrength * player.defenseBuff

func getWallDMG():
	return wallDmg


func getDmg(dmg):
	hp = hp - dmg
	if(hp <= 0):
		queue_free()

func runTimer():
	$BuildTime.start()
	timerRunning = true

func _on_BuildTime_timeout():
	if($".".is_in_group("playerBuilding")):
		timerRunning = false


func _on_Repair_timeout():
	hp = 250

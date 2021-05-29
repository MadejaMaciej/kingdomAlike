extends Area2D

var hp
var player
var wallDmg

func _ready():
	player = get_node("/root/Level/Player")
	hp = 500
	player.wallBuilded(self)
	wallDmg = 10
	updateWallDMG()

func getDmg(dmg):
	hp = hp - dmg
	if(hp <= 0):
		queue_free()

func updateWallDMG():
	wallDmg = player.population.sword * player.soliderStrength * player.defenseBuff

func getWallDMG():
	return wallDmg

func _on_Repair_timeout():
	hp = 500

extends Area2D

var player
var buildingCost
var moneyStored
var hp

func _ready():
	player = get_node("/root/Level/Player")


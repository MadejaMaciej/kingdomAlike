extends Timer

var timer
var side
var instance

func _ready():
	timer = self
	timer.connect("timeout", timer, "respawnZombie")
	start(10)

func respawnZombie():
	var zombieScene = preload("res://Blueprints/Enemies/Zombies/Zombie1.tscn")
	instance = zombieScene.instance()
	get_node("/root/Level").add_child(instance)

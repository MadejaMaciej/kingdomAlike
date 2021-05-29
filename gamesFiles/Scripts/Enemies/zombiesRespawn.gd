extends Timer

var timer
var side
var instance
var wave
var zombiesPop
var resps

func _ready():
	resps = 0
	wave = 0
	zombiesPop = 5
	timer = self
	timer.connect("timeout", timer, "respawnZombie")

func respawnZombie():
	if(resps<(wave*zombiesPop)+zombiesPop):
		var zombieScene = preload("res://Blueprints/Enemies/Zombies/Zombie1.tscn")
		instance = zombieScene.instance()
		get_node("/root/Level/spawner").add_child(instance)
		instance.add_to_group("zombie")
		instance.add_to_group("z-1")
		instance.z_index = -1
		resps = resps + 1
	else:
		wave = wave + 1
		stopWave()
		resps = 0

func startWave():
	timer.start()

func stopWave():
	timer.stop()


func _on_Wave_timeout():
	startWave()

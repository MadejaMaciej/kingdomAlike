extends Timer

var timer
var side
var instance
var wave
var zombiesPop
var resps
var zombies

func _ready():
	resps = 0
	wave = 0
	zombiesPop = 5
	zombies = 0
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
		zombies = zombies + 1
		var part1 = "Zombies left in wave: "
		var part2 = str(zombies)
		var together = part1+part2
		get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/ZombiesLeft").text = together
	else:
		wave = wave + 1
		var part1 = "Wave: "
		var part2 = str(wave)
		var together = part1+part2
		get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/ZombiesLeft2").text = together
		stopWave()
		resps = 0

func startWave():
	timer.start()

func stopWave():
	timer.stop()

func killZombie():
	zombies -= 1
	var part1 = "Zombies left in wave: "
	var part2 = str(zombies)
	var together = part1+part2
	get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/ZombiesLeft").text = together

func _on_Wave_timeout():
	startWave()

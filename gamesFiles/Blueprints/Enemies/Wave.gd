extends Timer

var wave
var waves
var timer
var player

func _ready():
	wave = 0
	waves = 10
	timer = self
	timer.connect("timeout", timer, "startWave")
	player = get_node("/root/Level/Player")

func startWave():
	wave = wave + 1
	if(wave > waves):
		win()

func win():
	player.won()

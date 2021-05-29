extends Timer

var wave
var waves
var timer

func _ready():
	wave = 0
	waves = 10
	timer = self
	timer.connect("timeout", timer, "startWave")

func startWave():
	wave = wave + 1
	if(wave > waves):
		win()

func win():
	print("Won")
	pass

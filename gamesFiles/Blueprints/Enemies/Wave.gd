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

func _process(delta):
	var part1 = "Seconds to next wave: "
	var timeleft = int(self.time_left)
	var text = str(timeleft)
	var together = part1 + text
	get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/NextWave").text = together

func startWave():
	wave = wave + 1
	if(wave > waves):
		win()

func win():
	player.won()

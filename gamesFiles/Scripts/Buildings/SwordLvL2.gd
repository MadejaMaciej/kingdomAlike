extends Area2D

var player
var buySolider

func _ready():
	player = get_node("/root/Level/Player")
	buySolider = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/BuySword")
	player.incraseBuff()

func showUI():
	buySolider.show()

func hideUI():
	buySolider.hide()

func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer")):
		hideUI()


func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer")):
		showUI()

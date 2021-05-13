extends Area2D

var buildButton

func _ready():
	buildButton = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/buildBuilding")

func showUI():
	buildButton.show()

func hideUI():
	buildButton.hide()

func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer")):
		hideUI()


func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer")):
		showUI()

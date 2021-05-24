extends "res://Scripts/Buildings/buildingBase.gd"

var healButton

func _ready():
	hp = 100
	healButton = get_node("/root/Level/Player/CanvasLayer/HUDController/HUD/heal")

func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer")):
		healButton.show()


func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer")):
		healButton.hide()

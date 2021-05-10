extends Area2D

var people
var maxPeople

func _ready():
	maxPeople = 10
	people = 10


func _on_Timer_timeout():
	if(people + 1 <= maxPeople):
		people += 1

func showUI():
	return

func hideUI():
	return

func _on_Area2D_body_entered(body):
	if(body.is_in_group("humanPlayer")):
		showUI()


func _on_Area2D_body_exited(body):
	if(body.is_in_group("humanPlayer")):
		hideUI()

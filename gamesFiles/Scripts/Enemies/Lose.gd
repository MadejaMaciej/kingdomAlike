extends Area2D

var player

func _ready():
	player = get_node("/root/Level/Player")

func _on_Area2D_body_entered(body):
	player = get_node("/root/Level/Player")
	if(body.is_in_group("zombie")):
		lost()

func lost():
	player.lose()

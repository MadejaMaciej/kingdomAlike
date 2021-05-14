extends Control

var level = "res://Maps/MainMenu.tscn"
var nextLevel = "res://Maps/level.tscn"

func _on_StartGame_pressed():
	get_tree().change_scene(nextLevel)

func _on_QuitGame_pressed():
	get_tree().quit()

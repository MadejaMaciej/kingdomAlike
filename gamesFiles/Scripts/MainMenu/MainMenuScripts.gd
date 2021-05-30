extends Control

var level = "res://Maps/MainMenu.tscn"
var nextLevel = "res://Maps/level.tscn"

func _on_StartGame_pressed():
	$Loading.show()
	$MenuElements.hide()
	get_tree().change_scene(nextLevel)

func _on_QuitGame_pressed():
	get_tree().quit()

func _on_HowToPlay_pressed():
	$MenuElements.hide()
	$Slides.show()


func _on_Next2_pressed():
	$Slides/s1.hide()
	$Slides/s2.show()


func _on_Prev1_pressed():
	$Slides/s2.hide()
	$Slides/s1.show()


func _on_Next3_pressed():
	$Slides/s2.hide()
	$Slides/s3.show()


func _on_Prev2_pressed():
	$Slides/s3.hide()
	$Slides/s2.show()


func _on_Next4_pressed():
	$Slides/s3.hide()
	$Slides/s4.show()


func _on_Prev3_pressed():
	$Slides/s4.hide()
	$Slides/s3.show()


func _on_MainMenuBack_pressed():
	$Slides.hide()
	$MenuElements.show()

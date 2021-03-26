extends Control

var pressed
var direction

func _ready():
	pressed = false

func _process(delta):
	if pressed and direction == 'left':
		Input.action_press("left") 
	elif pressed and direction == 'right':
		Input.action_press("right") 

func _on_Left_button_down():
	if !pressed:
		pressed = true
		direction = 'left'


func _on_Left_button_up():
	pressed = false
	direction = null
	Input.action_release("left")


func _on_Right_button_down():
	if !pressed:
		pressed = true
		direction = 'right'


func _on_Right_button_up():
	pressed = false
	direction = null
	Input.action_release("right")

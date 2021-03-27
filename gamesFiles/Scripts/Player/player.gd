extends KinematicBody2D

export var speed = 400
var screen_size
var lastMove

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
		lastMove = 'right'
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		lastMove = 'left'
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		velocity = move_and_slide(velocity)
		if lastMove == 'left':
			$AnimatedSprite.play("Run_left")
		else:
			$AnimatedSprite.play("Run_right")
	else:
		if lastMove == 'left':
			$AnimatedSprite.play("Idle_left")
		else:
			$AnimatedSprite.play("Idle_right")

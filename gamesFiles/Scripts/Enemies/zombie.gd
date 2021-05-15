extends KinematicBody2D

var hp
var speed
var velocity
var x
var maxSpeed
var maxHP

func _ready():
	velocity = Vector2.ZERO
	velocity.x = 1
	x = velocity.x

func _physics_process(_delta):
	velocity = x * speed
	velocity = move_and_slide(Vector2(velocity, 0))
	if x < 0:
		$AnimatedSprite.play("Run_left")
	else:
		$AnimatedSprite.play("Run_right")

func setSpeed(sp = 200):
	speed = sp

func getSpeed():
	return speed

func setHp(health = 100):
	hp = health

func getHp():
	return hp

func setMaxHp(maxhp = 100):
	maxHP = maxhp

func getMaxHp():
	return maxHP

func setMaxSpeed(sp = 200):
	maxSpeed = sp

func getMaxSpeed():
	return maxSpeed

func destroyObject():
	queue_free()

func getDamage(dmg):
	hp -= dmg
	if hp <= 0:
		destroyObject()

func heal(amount):
	if hp + amount <= maxHP:
		hp += amount

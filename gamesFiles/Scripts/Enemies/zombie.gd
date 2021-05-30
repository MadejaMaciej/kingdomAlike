extends KinematicBody2D

var hp
var speed
var velocity
var x
var maxSpeed
var maxHP
var player
var attackStrength
var hit

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
	$attackCooldown.stop()
	$AnimatedSprite.play("Die")
	yield( get_node("AnimatedSprite"), "animation_finished" )
	free()

func free():
	queue_free()

func setAttack(attack = 5):
	attackStrength = attack

func attackPlayer():
	player.tookDmg(attackStrength)

func attackWall():
	player.wall.getDmg(attackStrength)

func getDamage(dmg):
	hp -= dmg
	if hp <= 0:
		destroyObject()

func heal(amount):
	if hp + amount <= maxHP:
		hp += amount

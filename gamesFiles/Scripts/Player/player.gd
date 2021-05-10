extends KinematicBody2D

export var speed = 400
var screen_size
var lastMove
var money
var hp
var maxHealth
var people
var maxPeople

var population

func _ready():
	screen_size = get_viewport_rect().size
	money = 10
	hp = 100
	maxHealth = 100
	people = 0
	maxPeople = 20
	population = {
		"worker": 0,
		"archer": 0,
		"pike": 0,
		"sword": 0,
		"engineer": 0
	}
	displayMoney(money)
	switchHearts(hp)
	displayPeople(people, maxPeople)

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

func displayPeople(ppl, maxPpl):
	var part1 = str(ppl)
	var part2 = str(maxPpl)
	var slash = "/"
	var together = part1 + slash + part2
	$CanvasLayer/HUDController/HUD/PeopleCounter/Label.text = str(together)

func displayMoney(money):
	$CanvasLayer/HUDController/HUD/coinDisplay/Label.text = str(money)

func die():
	get_tree().quit()

func switchHearts(health):
	$CanvasLayer/HUDController/HUD/healthDisplay.switchHeartsHud(health)

func getCoins():
	return money

func getHP():
	return hp

func earnMoney(amount):
	money += amount
	displayMoney(money)

func loseMoney(amount):
	if(money - amount < 0):
		return
	else:
		money -= amount
		displayMoney(money)

func setHP(setNum):
	if(setNum > maxHealth):
		hp = maxHealth
		switchHearts(hp)
	else:
		hp += setNum
		switchHearts(hp)

func setCoins(amount):
	money += amount
	displayMoney(money)

func tookDmg(dmg):
	hp -= dmg
	if(hp<0):
		die()
	switchHearts(hp)

func heal(amount):
	if(hp+amount <=maxHealth):
		hp += amount
		switchHearts(hp)
	else:
		hp = maxHealth
		switchHearts(hp)

func buyWorker():
	if(people + 1 <= maxPeople and money - 1 >= 0):
		money -= 1
		people += 1
		population.worker += 1
		displayPeople(people, maxPeople)
		displayMoney(money)

func loseWorker(type):
	if(people - 1 >= 0 and population[type] - 1 >= 0):
		people -= 1
		population[type] -= 1

func buildedTent():
	maxPeople += 5
	displayPeople(people, maxPeople)

func buildedHouse():
	maxPeople += 15
	displayPeople(people, maxPeople)

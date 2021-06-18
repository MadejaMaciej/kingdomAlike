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
var collidingBuilding
var playerBuilding
var hallBuilded

var defenseBuff

var soliderStrength

var wall

func _ready():
	screen_size = get_viewport_rect().size
	money = 20
	hp = 100
	maxHealth = 100
	people = 0
	maxPeople = 20
	soliderStrength = 10
	hallBuilded = false
	population = {
		"worker": 0,
		"archer": 0,
		"pike": 0,
		"sword": 0,
		"engineer": 0,
		"farmers": 0
	}
	displayMoney(money)
	switchHearts(hp)
	displayPeople(people, maxPeople)
	defenseBuff = 1

func _physics_process(_delta):
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

func displayMoney(mon):
	$CanvasLayer/HUDController/HUD/coinDisplay/Label.text = str(mon)

func die():
	get_tree().paused = true
	$CanvasLayer/HUDController/HUD/endDied.show()

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
	if(setNum + hp > maxHealth):
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
	if(people + 1 <= maxPeople and money - 1 >= 0 and playerBuilding.getPeople() > 0):
		money -= 1
		people += 1
		population.worker += 1
		displayPeople(people, maxPeople)
		displayMoney(money)
		playerBuilding.buyWorker()

func loseWorker(type):
	if(people - 1 >= 0 and population[type] - 1 >= 0):
		people -= 1
		population[type] -= 1
		displayPeople(people, maxPeople)

func buildedTent():
	maxPeople += 5
	displayPeople(people, maxPeople)

func getPlayerBuilding():
	return playerBuilding

func buildedHouse():
	maxPeople += 15
	displayPeople(people, maxPeople)

func _on_Area2D_area_entered(area):
	if(area.is_in_group("building")):
		collidingBuilding = area
	if(area.is_in_group("playerBuilding")):
		playerBuilding = area

func incraseBuff():
	defenseBuff += 1
	wall.updateWallDMG()

func _on_Area2D_area_exited(area):
	if(area.is_in_group("building")):
		collidingBuilding = null
	if(area.is_in_group("playerBuilding")):
		playerBuilding = null

func switchWorkerTo(to):
	if(money - 1 >= 0 and population.worker - 1  >= 0):
		population.worker -= 1
		switcherPop(to)

func switcherPop(to):
	if(to == "archer" ): 
		population.archer += 1
	elif(to == "pike"):
		population.pike += 1
	elif(to == "sword"):
		population.sword += 1
		var txt = str(population.sword)
		$CanvasLayer/HUDController/HUD/swordsss.text = str(txt)
		if(wall != null):
			wall.updateWallDMG()
	elif(to == "farmers"):
		population.farmers +=1
		var txt = str(population.farmers)
		$CanvasLayer/HUDController/HUD/farm.text = str(txt)
	else:
		population.engineer += 1

func wallBuilded(wallBuild):
	wall = wallBuild

func won():
	get_tree().paused = true
	$CanvasLayer/HUDController/HUD/won.show()

func lose():
	get_tree().paused = true
	$CanvasLayer/HUDController/HUD/endWallBreached.show()

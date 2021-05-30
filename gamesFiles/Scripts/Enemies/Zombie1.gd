extends "res://Scripts/Enemies/zombie.gd"

var entered
var hitPlayer

func _ready():
	player = get_node("/root/Level/Player")
	velocity = Vector2.ZERO
	velocity.x = -1
	x = velocity.x
	randomize()
	setSpeed(randi()%200+200)
	setMaxHp(randi()%100+50)
	setHp(maxHP)
	setMaxSpeed()
	setAttack(randi()%10+1)
	entered = false
	hitPlayer = false

func _physics_process(_delta):
	velocity = x * speed
	velocity = move_and_slide(Vector2(velocity, 0))
	if(!entered and !hitPlayer):
		if x < 0:
			$AnimatedSprite.play("Run_left")
		else:
			$AnimatedSprite.play("Run_right")
	else:
		$AnimatedSprite.play("Attack")

func _on_Area2D_area_entered(area):
	if(area.is_in_group("wall1") or area.is_in_group("WallReady")):
		entered = true
		if(hitPlayer == false):
			$attackCooldown.start()

func _on_Area2D_area_exited(area):
	if(area.is_in_group("wall1") or area.is_in_group("WallReady")):
		entered = false
		if(hitPlayer == false):
			$attackCooldown.stop()


func _on_attackCooldown_timeout():
	if(entered):
		player.wall.getDmg(attackStrength)
		getDamage(player.wall.getWallDMG())
	if(hitPlayer):
		player.tookDmg(attackStrength)
	if(entered or hitPlayer):
		$AnimatedSprite.play("Attack")


func _on_Area2D_body_entered(body):
	if(body == player):
		hitPlayer = true
		if(entered == false):
			$attackCooldown.start()


func _on_Area2D_body_exited(body):
	if(body == player):
		hitPlayer = false
		if(entered == false):
			$attackCooldown.stop()

extends Control

var pressed
var direction
var healWorth
var player

func _ready():
	player = get_node("/root/Level/Player")
	pressed = false
	healWorth = 25

func _process(_delta):
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


func _on_buyWorker_pressed():
	player.buyWorker()


func _on_buildBuilding_pressed():
	var building = player.getPlayerBuilding()
	if(player.money > building.buildingCost):
		player.loseMoney(building.buildingCost)
		building.runTimer()


func _on_Heal_pressed():
	if(player.money > 4):
		player.setHP(healWorth)
		player.loseMoney(5)


func _on_Pause_pressed():
	get_tree().paused = true
	$pause_popup.show()


func _on_Button_pressed():
	get_tree().paused = false
	$pause_popup.hide()


func _on_Button2_pressed():
	save_game()
	


func save_game():
	get_tree().paused = false
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(to_json(node_data))
	save_game.close()
	var level = "res://Maps/MainMenu.tscn"
	get_tree().change_scene(level)


func _on_BuySword_pressed():
	if(player.money > 0 and player.population.worker > 0):
		player.loseMoney(1)
		player.switchWorkerTo("sword")

func _on_BuyFarmer_pressed():
	if(player.money  > 0 and player.population.worker > 0):
		player.loseMoney(1)
		player.switchWorkerTo("farmers")

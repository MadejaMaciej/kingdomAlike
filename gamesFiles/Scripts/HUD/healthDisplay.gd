extends Control

func switchHeartsHud(health):
	if(health > 75):
		$"25-health".show()
		$"50-health".show()
		$"75-health".show()
		$"100-health".show()
		return
	elif(health > 50):
		$"25-health".show()
		$"50-health".show()
		$"75-health".show()
		$"100-health".hide()
		return
	elif(health > 25):
		$"25-health".show()
		$"50-health".show()
		$"75-health".hide()
		$"100-health".hide()
		return
	else:
		$"25-health".show()
		$"50-health".hide()
		$"75-health".hide()
		$"100-health".hide()
		return

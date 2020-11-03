extends CanvasLayer

func _ready():
	pass 

func change_potion(potion):
	$WhichPotion.text = "Potion Holding: " + potion

extends CanvasLayer

const BUFF_BAR = preload("res://BuffBar.tscn")

func _ready():
	pass

func change_potion(potion):
	$WhichPotion.text = "Potion Holding: " + potion

func add_buff(type, time):
	var new_buff = BUFF_BAR.instance()
	new_buff.setup(type, time)
	$VBoxContainer.add_child(new_buff)

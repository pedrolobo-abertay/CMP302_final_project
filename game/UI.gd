extends CanvasLayer

const BUFF_BAR = preload("res://BuffBar.tscn")

onready var which_potion = $HboxContainer/WhichPotion
onready var drink_effect = $HBoxContainer/DrinkEffect
onready var throw_effect = $HBoxContainer/ThrowEffect

func _ready():
	pass

func change_potion(potion, text_drink, text_throw):
	which_potion.text = "Potion Holding: " + potion

func add_buff(type, time, text):
	for bar in $Effects.get_children():
		if bar.type == type:
			bar.queue_free()
			break
	var new_buff = BUFF_BAR.instance()
	new_buff.setup(type, time, text)
	$Effects.add_child(new_buff)

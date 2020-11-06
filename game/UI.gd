extends CanvasLayer

const BUFF_BAR = preload("res://BuffBar.tscn")

onready var which_potion = $HBoxContainer/WhichPotion
onready var drink_effect = $HBoxContainer/DrinkEffect
onready var throw_effect = $HBoxContainer/ThrowEffect

var health = 100

func _ready():
	drink_effect.hide()
	throw_effect.hide()

func change_potion(potion, text_drink, text_throw):
	which_potion.text = "Potion Holding: " + potion
	if potion == "None":
		drink_effect.hide()
		throw_effect.hide()
	else:	
		drink_effect.text = "Drink Effect: " + text_drink
		throw_effect.text = "Throw Effect: " + text_throw
		
		drink_effect.show()
		throw_effect.show()
		
		
func add_buff(type, time, text):
	for bar in $Effects.get_children():
		if bar.type == type:
			bar.queue_free()
			break
	var new_buff = BUFF_BAR.instance()
	new_buff.setup(type, time, text)
	$Effects.add_child(new_buff)

func update_health(health):	
	$HealthBar.value = health
	
	
	
	
	
	

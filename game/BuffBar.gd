extends Control

var type
var time

func _ready():
	pass 

func setup(_type, _time):
	type = _type
	time = _time
	if type == "Dash":
		$Sprite.texture = load("res://Assets/green_potion.png")
		$ProgressBar.add_stylebox_override("fg", load("res://Style/BuffBarGreen.tres"))
	elif type == "Movement":
		$Sprite.texture = load("res://Assets/red_potion.png")
		$ProgressBar.add_stylebox_override("fg", load("res://Style/BuffBarRed.tres"))
	elif type == "Invincibility":
		$Sprite.texture = load("res://Assets/blue_potion.png")
		$ProgressBar.add_stylebox_override("fg", load("res://Style/BuffBarBlue.tres"))	

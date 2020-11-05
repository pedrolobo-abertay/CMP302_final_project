extends Control

var type
var time

func _ready():
	$Tween.interpolate_property($ProgressBar, "value", 100, 0, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func setup(_type, _time, _text):
	type = _type
	time = _time
	$Text.text = _text
	if type == "Dash":
		$Sprite.texture = load("res://Assets/green_potion.png")
		$ProgressBar.add_stylebox_override("fg", load("res://Style/BuffBarGreen.tres"))
	elif type == "Movement":
		$Sprite.texture = load("res://Assets/red_potion.png")
		$ProgressBar.add_stylebox_override("fg", load("res://Style/BuffBarRed.tres"))
	elif type == "Invincibility":
		$Sprite.texture = load("res://Assets/blue_potion.png")
		$ProgressBar.add_stylebox_override("fg", load("res://Style/BuffBarBlue.tres"))


func _on_Tween_tween_all_completed():
	queue_free()

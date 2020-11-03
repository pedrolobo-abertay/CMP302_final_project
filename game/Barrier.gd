extends Node2D

func _ready():
	pass 

func setup(time):
	$Timer.wait_time = time

func _on_Timer_timeout():
	queue_free()

extends Node2D

var margin = 100

func _ready():
	pass 


func get_random_position():
	randomize()
	
	var x = rand_range($LeftWall.global_position.x + margin, $RightWall.global_position.x - margin)
	
	var y = rand_range($TopWall.global_position.y + margin, $BottomWall.global_position.y - margin)

	return Vector2(x, y)

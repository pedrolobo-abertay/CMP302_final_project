extends KinematicBody2D

var movement = Vector2()
var speed = 1000
var friction = 1500
var max_speed = 800


func _ready():
	pass

func _process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_top"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_bot"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	
	if move_vec == Vector2.ZERO:
		var direction_friction = friction * movement.normalized()
		if movement.length() <= friction:
			movement = Vector2()
		else:
			movement -= direction_friction
	else:
		move_vec = move_vec.normalized()
		movement += move_vec * speed * delta
	
		if movement.length() >= max_speed:
			#movement = movement.normalized() * max_speed
			movement = movement.clamped(max_speed)
	
	movement = move_and_slide(movement)
	
	
func take_damage(damage):
	pass
	
	
	
	

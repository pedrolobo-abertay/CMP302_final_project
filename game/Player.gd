extends KinematicBody2D

const MOV = preload("res://Potions/Movement.tscn")

signal throw_potion
signal drink

var movement = Vector2()
var speed = 1000
var friction = 1500
var max_speed = 800
var new_potion
var potion_active = false
var potion_effect_active = false
var target_position
var potion_type
var normal_speed = 1000

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
	
func take_damage():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("take_damage")
	
	
func throw():
	potion_active = false
	var new_direction = (get_global_mouse_position() - position).normalized()
	emit_signal("throw_potion", new_direction)
	
func drink():
	potion_active = false
	emit_signal("drink")
		

func _input(event):
	if event.is_action_pressed("throw") and potion_active:
		throw()
	if event.is_action_pressed("drink") and potion_active:
		drink()

func speed_up(_speed):
	speed = _speed
	$PotionDuration.start()

func _on_PotionDuration_timeout():
	speed = normal_speed

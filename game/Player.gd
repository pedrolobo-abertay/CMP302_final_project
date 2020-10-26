extends KinematicBody2D

const MOV = preload("res://Potions/MovementPotion.tscn")

var movement = Vector2()
var speed = 1000
var friction = 1500
var max_speed = 800
var new_potion
var potion_active = false
var potion_effect_active = false
var target_position

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
	if Input.is_action_just_pressed("throw") and potion_active:
		throw()
		target_position = get_global_mouse_position()
	if Input.is_action_just_pressed("drink") and potion_active:
		drink()
	
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
	
	if potion_active:
		new_potion.position = position
	
func take_damage():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("take_damage")
	
func handle_movement_potion():
	if potion_active:
		return
	
	new_potion = MOV.instance()
	
	new_potion.position = position
	
	$Potion.add_child(new_potion)
	
	potion_active = true
	
	
func throw():
	potion_active = false
	var new_direction = (get_global_mouse_position() - position).normalized()
	new_potion.throw(new_direction)
	
func drink():
	if not potion_effect_active:
		$PotionDuration.start()
		speed = 10000
		

func _on_PotionDuration_timeout():
	potion_effect_active = false
	speed = 1000

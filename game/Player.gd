extends KinematicBody2D

const MOV = preload("res://Potions/Movement.tscn")
const NORMAL_SPEED = 1000
const FRICTION = 1500
const MAX_SPEED = 800

signal throw_potion
signal drink
signal health
signal died

var movement = Vector2()
var speed = NORMAL_SPEED
var potion_active = false
var potion_effect_active = false
var can_dash = false
var dash_force = 5000
var dash_vec = Vector2()
var invincible = false
var health = 100

func _ready():
	emit_signal("health", health)

func _process(delta):
	if dash_vec != Vector2():
# warning-ignore:return_value_discarded
		move_and_slide(dash_vec)
		return
	
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
		var direction_friction = FRICTION * movement.normalized()
		if movement.length() <= FRICTION:
			movement = Vector2()
		else:
			movement -= direction_friction
	else:
		move_vec = move_vec.normalized()
		movement += move_vec * speed * delta
	
		if movement.length() >= MAX_SPEED:
			#movement = movement.normalized() * max_speed
			movement = movement.clamped(MAX_SPEED)
	
	movement = move_and_slide(movement)
	
func take_damage(damage):
	if invincible:
		return
	$AnimationPlayer.stop()
	$AnimationPlayer.play("take_damage")

	health -= damage
	emit_signal("health", health)
	if health <=0:
		die()
	
func throw():
	potion_active = false
	var new_direction = (get_global_mouse_position() - position).normalized()
	emit_signal("throw_potion", new_direction, get_global_mouse_position())
	
func drink():
	potion_active = false
	emit_signal("drink")
		

func _input(event):
	if event.is_action_pressed("throw") and potion_active:
		throw()
	if event.is_action_pressed("drink") and potion_active:
		drink()
	if event.is_action_pressed("dash") and can_dash:
		dash()
		
func speed_up(_speed):
	$TimerMov.stop()
	speed = _speed
	$TimerMov.start()

func enable_dash(time):
	$TimerDash.stop()
	can_dash = true
	$TimerDash.start(time)
	
	
func dash():
	if dash_vec != Vector2():
		return
	var direction = (get_global_mouse_position() - position).normalized()
	movement = Vector2()
	$Tween.interpolate_property(self, "dash_vec", direction * dash_force, Vector2(), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func invincibility(value):
	$TimerInvin.stop()
	
	invincible = true
	
	$TimerInvin.start(value)


func _on_TimerDash_timeout():
	can_dash = false


func _on_TimerInvin_timeout():
	invincible = false


func _on_TimerMov_timeout():
	 speed = NORMAL_SPEED

func die():
	emit_signal("died")
	queue_free()





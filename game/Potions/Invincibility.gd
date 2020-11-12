extends Node2D

const EPSLON = 1
const type = "Invincibility"
const RADIUS = 80
const SPEED = 1000
const TIME_INVIN = 5

var direction = Vector2()
var state = "idle"
var player = null
var target_position
var barrier_time = 5

signal barrier
signal new_buff

func setup(_player):
	player = _player

func _on_Area2D_body_entered(body):
	if body.is_in_group("wall") and state == "throwing":
		queue_free()

	
func throw(_direction, _target_position):
	state = "throwing"
	direction = _direction
	target_position = _target_position
	

func _process(delta):
	if state == "throwing":
			
		var mov_direction = (target_position - position).normalized() 
		
		var length = min(delta * SPEED, (target_position - position).length())

		position += mov_direction * length
			
		if (position - target_position).length() <= EPSLON:
			explode()
	
	
func drink():
	player.invincibility(TIME_INVIN)
	emit_signal("new_buff", type, TIME_INVIN, "imune to damage")
	queue_free()
	
func explode():
	emit_signal("barrier", target_position, barrier_time)
	queue_free()


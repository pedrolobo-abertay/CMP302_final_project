extends Node2D

const EPSLON = 1
const type = "Movement"
const speed = 1000
const RADIUS = 80

var direction = Vector2()
var state = "idle"
var player = null
var boost = 5000
var target_position
var boost_time = 5
var stun_time = 5

signal explode
signal new_buff

func _ready():
	pass 

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
		
		var length = min(delta * speed, (target_position - position).length())

		position += mov_direction * length
			
		if (position - target_position).length() <= EPSLON:
			explode()
	
	
func drink():
	player.speed_up(boost)
	emit_signal("new_buff", type, boost_time, "increased speed")
	queue_free()
	
func explode():
	emit_signal("explode", target_position, RADIUS, "stun", stun_time)
	queue_free()
	
	

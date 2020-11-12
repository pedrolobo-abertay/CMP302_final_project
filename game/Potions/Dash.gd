extends Node2D

const EPSLON = 1
const type = "Dash"
const RADIUS = 80
const SPEED = 1000

var direction = Vector2()
var state = "idle"
var player = null
var target_position
var damage = 5
var dash_time = 10

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
		
		var length = min(delta * SPEED, (target_position - position).length())

		position += mov_direction * length
			
		if (position - target_position).length() <= EPSLON:
			explode()
	
	
func drink():
	player.enable_dash(10)
	emit_signal("new_buff", type, dash_time, "dash with spacebar")
	queue_free()
	
func explode():
	emit_signal("explode", target_position, RADIUS, "damage", damage)
	queue_free()

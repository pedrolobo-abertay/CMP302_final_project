extends Node2D

var active = false
var new_pos
var speed = 500
var arena = null
const EPSLON = 1

func _ready():
	pass

func _process(delta):
	if not new_pos or not active:
		return
	var mov_direction = (new_pos - position).normalized() 
	
	var length = min(delta * speed, (new_pos - position).length())

	position += mov_direction * length
		
	if (position - new_pos).length() <= EPSLON:
		new_position()
	
	
	
func new_position():
	new_pos = arena.get_random_position()
	
	
	
func setup(_arena):
	arena = _arena
	new_position()
	
func _input(event):
	if event.is_action_pressed("toggle_enemy"):
		active = not active
	

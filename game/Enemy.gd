extends Node2D

var active = false
var new_pos
var speed = 300
var arena = null
var player = null
var stunned = false
const EPSLON = 1

signal shoot

func _ready():
	pass

func _process(delta):
	if not new_pos or not active or stunned:
		return
		
	var mov_direction = (new_pos - position).normalized() 
	var length = min(delta * speed, (new_pos - position).length())

	position += mov_direction * length
		
	if (position - new_pos).length() <= EPSLON:
		new_position()
	
	
func new_position():
	new_pos = arena.get_random_position()
	
func setup(_arena, _player):
	arena = _arena
	player = _player
	new_position()
	
func _input(event):
	if event.is_action_pressed("toggle_enemy"):
		active = not active
	

func _on_Timer_timeout():
	if not active or stunned or not player:
		return
	emit_signal("shoot", global_position, \
	(player.global_position - global_position).normalized())
	
func stun(time):
	if stunned:
		return
	stunned =  true
	
	yield(get_tree().create_timer(time), "timeout")
	
	stunned = false
	
func damage():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("Damage")
	
func player_died():
	player = null
	
	
	
	
	
	
	
	

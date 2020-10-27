extends Node2D

const type = "Movement"
const speed = 1000
var direction = Vector2()
var state = "idle"
var player = null
var boost = 5000

func _ready():
	pass 

func setup(_player):
	player = _player

func _on_Area2D_body_entered(body):
	if body.is_in_group("wall") and state == "throwing":
		queue_free()

	
func throw(_direction):
	state = "throwing"
	direction = _direction
	

func _process(delta):
	if state == "throwing":
		position += speed * delta * direction
	
func drink():
	player.speed_up(boost)
	queue_free()
	
	
	
	

extends Node2D

const speed = 1000
var direction
var damage = 20

func _ready():
	pass 

func setup(_position, _direction):
	position = _position
	direction = _direction
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("wall"):
		queue_free()
	if body.is_in_group("player"):
		body.take_damage(damage)
		queue_free()

func _process(delta):
	
	position += speed * delta * direction
	
	
	
	
	

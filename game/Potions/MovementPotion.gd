extends Node2D

signal movement_potion

const speed = 1000
var direction

func _ready():
	pass 

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("movement_potion")

func throw(_direction):
	direction = _direction

func _process(delta):
	
	position += speed * delta * direction

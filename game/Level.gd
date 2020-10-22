extends Node2D

const PROJECTILE = preload("res://Projectile.tscn")

func _ready():
	$Enemy.setup($Arena)
	
	
func create_projectile(_position, _direction):
	var new_projectile = PROJECTILE.instance()
	
	new_projectile.setup(_position, _direction)

	$Projectiles.add_child(new_projectile)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		create_projectile(Vector2(500, 500), Vector2(1, 0))

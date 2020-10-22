extends Node2D

const PROJECTILE = preload("res://Projectile.tscn")

func _ready():
	$Enemy.setup($Arena, $Player)
# warning-ignore:return_value_discarded
	$Enemy.connect("shoot", self, "create_projectile")
	
func create_projectile(_position, _direction):
	var new_projectile = PROJECTILE.instance()
	
	new_projectile.setup(_position, _direction)

	$Projectiles.add_child(new_projectile)

func _input(_event):
	pass

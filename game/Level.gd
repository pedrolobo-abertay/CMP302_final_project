extends Node2D

const PROJECTILE = preload("res://Projectile.tscn")
const PATHPOTION = "res://Potions/"
const EXPLOSION = preload("res://Explosion.tscn")
const BARRIER = preload("res://Barrier.tscn")
var potion_holding

func _ready():
	$Enemy.setup($Arena, $Player)
# warning-ignore:return_value_discarded
	$Enemy.connect("shoot", self, "create_projectile")
# warning-ignore:return_value_discarded
	$Player.connect("throw_potion", self, "throw")
# warning-ignore:return_value_discarded
	$Player.connect("drink", self, "drink")
	
	
func create_projectile(_position, _direction):
	var new_projectile = PROJECTILE.instance()
	
	new_projectile.setup(_position, _direction)

	$Projectiles.add_child(new_projectile)

func _input(_event):
	pass

	
func _process(_delta):
	if potion_holding:
		potion_holding.position = $Player.position
	

func _on_PotionSpawn_get_potion(type):	
	call_deferred("create_potion", type)

	
func throw(direction, target_position):
	$UI.change_potion("None")
	potion_holding.throw(direction, target_position)
	potion_holding = null

func drink():
	$UI.change_potion("None")
	potion_holding.drink()
	potion_holding = null

func create_potion(type):
	if potion_holding and potion_holding.type == type:
		return
	elif potion_holding:
		potion_holding.queue_free()
	
	$UI.change_potion(type)
		
	var path_potion = PATHPOTION+type+".tscn"
	potion_holding = load(path_potion).instance()
	$Potions.add_child(potion_holding)
	potion_holding.position = $Player.position
	$Player.potion_active = true
	potion_holding.setup($Player)
	
	if type == "Invincibility":
		potion_holding.connect("barrier", self, "create_barrier")
	else:
		potion_holding.connect("explode", self, "create_explosion")
	
func create_explosion(target_position, radius, type, value):
	var new_explosion = EXPLOSION.instance()
	new_explosion.position = target_position
	new_explosion.setup(radius, type, value)
	
	$Explosions.add_child(new_explosion)
	
	
func create_barrier(target_position, time):
	var new_barrier = BARRIER.instance()
	new_barrier.position = target_position
	new_barrier.setup(time)
	
	$Barriers.add_child(new_barrier)
	
	
	

extends Node2D

const PROJECTILE = preload("res://Projectile.tscn")
const PATHPOTION = "res://Potions/"
const EXPLOSION = preload("res://Explosion.tscn")
const BARRIER = preload("res://Barrier.tscn")
const PLAYER = preload("res://Player.tscn")
const POTIONS_TEXTS = {
	"Movement": {
		"drink": "increase speed",
		"throw": "stun enemy"
		},
	"Dash" : {
		"drink": "can dash",
		"throw": "damage enemy"
		},
	"Invincibility": {
		"drink": "imune to damage",
		"throw": "create barrier"
		}
	}
var potion_holding
var player

func _ready():
	create_player()
# warning-ignore:return_value_discarded
	$Enemy.connect("shoot", self, "create_projectile")
	
	
func create_projectile(_position, _direction):
	var new_projectile = PROJECTILE.instance()
	
	new_projectile.setup(_position, _direction)

	$Projectiles.add_child(new_projectile)

func _input(_event):
	pass

	
func _process(_delta):
	if potion_holding and player:
		potion_holding.position = player.position
	

func _on_PotionSpawn_get_potion(type):	
	call_deferred("create_potion", type)

	
func throw(direction, target_position):
	$UI.change_potion("None", null, null)
	potion_holding.throw(direction, target_position)
	potion_holding = null

func drink():
	$UI.change_potion("None", null, null)
	potion_holding.drink()
	potion_holding = null

func create_potion(type):
	if potion_holding and potion_holding.type == type:
		return
	elif potion_holding:
		potion_holding.queue_free()
	
	$UI.change_potion(type, POTIONS_TEXTS[type].drink, POTIONS_TEXTS[type].throw)
		
	var path_potion = PATHPOTION+type+".tscn"
	potion_holding = load(path_potion).instance()
	$Potions.add_child(potion_holding)
	potion_holding.position = player.position
	player.potion_active = true
	potion_holding.setup(player)
	
	if type == "Invincibility":
		potion_holding.connect("barrier", self, "create_barrier")
	else:
		potion_holding.connect("explode", self, "create_explosion")
		
	potion_holding.connect("new_buff", $UI, "add_buff")
	
	
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
	
func die_player():
	$UI.change_potion("None", null, null)
	player = null
	if potion_holding:
		potion_holding.queue_free()
		potion_holding = null
	yield(get_tree().create_timer(3), "timeout")
	create_player()
	
	

func create_player():
	player = PLAYER.instance()
	player.position = Vector2(500, 500)
	$Enemy.setup($Arena, player)
# warning-ignore:return_value_discarded
	player.connect("throw_potion", self, "throw")
# warning-ignore:return_value_discarded
	player.connect("drink", self, "drink")
# warning-ignore:return_value_discarded
	player.connect("died", self, "die_player")
# warning-ignore:return_value_discarded
	player.connect("died", $Enemy, "player_died")
# warning-ignore:return_value_discarded
	player.connect("health", $UI, "update_health")	
	$PlayerPlace.add_child(player)








	

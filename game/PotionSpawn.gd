extends Node2D

export var type : String

signal get_potion

func _ready():
	if type == "Movement":
		$Sprite.texture = load("res://Assets/red_square.png")
		$SpritePotion.texture = load("res://Assets/red_potion.png")
	elif type == "Dash":
		$Sprite.texture = load("res://Assets/green_square.png")
		$SpritePotion.texture = load("res://Assets/green_potion.png")
	elif type == "Invincibility":
		$Sprite.texture = load("res://Assets/blue_square.png")
		$SpritePotion.texture = load("res://Assets/blue_potion.png")

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("get_potion", type)

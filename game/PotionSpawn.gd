extends Node2D

export var type : String

signal get_potion

func _ready():
	pass 


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("get_potion", type)

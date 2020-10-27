extends Node2D

var type

func setup(_radius, _type):
	$Area2D/CollisionShape2D.shape.radius = _radius
	type = _type

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("enemy"):
		if type == "stun":
			pass
		if type == "damage":
			pass

func _on_Timer_timeout():
	queue_free()

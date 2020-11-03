extends Node2D

var type
var value

func setup(_radius, _type, _value):
	$Area2D/CollisionShape2D.shape.radius = _radius
	type = _type
	value = _value

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("enemy"):
		if type == "stun":
			area.get_parent().stun(value)
		if type == "damage":
			area.get_parent().damage()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

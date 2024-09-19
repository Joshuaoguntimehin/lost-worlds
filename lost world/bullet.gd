extends AnimatedSprite2D
var bullet_impact_effect = preload("res://bulletimpacteffect.tscn")
var speed : int = 500
var direction : int
var damage_amount : int = 1

func _physics_process(delta):
	move_local_x(direction * speed * delta )

func _on_timer_timeout():
	queue_free()


func _on_hitbox_area_exited(area):
	print("bullet area dictected")
	bulletimpact()
func get_damage_amount() -> int:
	return damage_amount
	
func _on_hitbox_body_entered(body):
	print("bullet area dictected")
	bulletimpact()

func bulletimpact():
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()

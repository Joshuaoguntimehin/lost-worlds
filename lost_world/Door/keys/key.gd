extends Node2D

@export var key_id : String

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		InventoralManager.add_is_inventory("key1", key_id)
		queue_free()

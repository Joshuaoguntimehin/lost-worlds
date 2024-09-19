extends Node2D
@export var next_scene : String

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var player = body as CharacterBody2D
		player.queue_free()
	
	
	emit get_tree().create_time(3.0).timeout
ScriptManager.transition_to_scean(next_scene)

func _on_area_2d_body_exited(body):
	pass # Replace with function body.


func _on_active_area_2d_2_body_entered(body):
	pass # Replace with function body.


func _on_active_area_2d_2_body_exited(body):
	pass # Replace with function body.

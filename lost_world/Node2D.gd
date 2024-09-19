extends Node2D
@export var next_scene : String

func _on_ex_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var player = body as CharacterBody2D
		player.queue_free()
	await get_tree().create_timer(3.0).timeout
	print("scene transition")
	SceneManager.transition_to_scene(next_scene)

extends Node
@export var next_scene : String

var scene : Dictionary = { "level1": "res://level_1.tscn",
							"level2": "res://next_floor.tscn"} 

func transition_to_scene(level : String):
	var scene_path : String = scene.get(level)
	
	if  scene_path != null:
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file(scene_path)
		

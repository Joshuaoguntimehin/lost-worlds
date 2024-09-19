extends Camera2D

@export_category("follow character")
@export var player : CharacterBody2D

@export_category("camere smoothing")
@export var smoothing_enabled : bool
@export_range(1, 10) var smoothing_distance : int = 8
var weight : float

func _ready(): 
	weight = float(11 - smoothing_distance) / 100

func _physics_process(delta):
	
	
	if player != null:
		var camera_position : Vector2
		
		if smoothing_enabled:
			weight = float(11 - smoothing_distance) / 100
			camera_position = lerp(global_position, player.global_position, weight)
		else:
			camera_position = player.global_position
		
		print("weight:", weight, "camera position:", camera_position, "camera pixel floor:", camera_position.floor())
		
		global_position = camera_position.floor()

extends Nodestate

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int

var player: CharacterBody2D
func on_process(delta: float):
	pass

func on_physics_process(delta: float):
	if not character_body_2d or not player:
		print("Error: character_body_2d or player is not initialized.")
		return
	
	var direction: int = 0  # Initialize direction with a default value
	if character_body_2d.global_position > player.global_position:
		animated_sprite_2d.flip_h = true
		direction = -1
	elif character_body_2d.global_position < player.global_position:
		animated_sprite_2d.flip_h = false
		direction = 1
		animated_sprite_2d.play("attack")
	
	# Update velocity
	character_body_2d.velocity.x += direction * speed * delta
	character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -speed, speed)
	character_body_2d.move_and_slide()

func enter():
	# Find the player node in the group 'player'
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0] as CharacterBody2D
	else:
		print("Error: No player node found in the 'player' group.")

func exit():
	pass

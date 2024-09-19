extends CharacterBody2D
var bullet = preload("res://bullet.tscn")
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var Max_Horizontal_Speed: int =300
@onready var mazule: Marker2D = $mazule
@onready var heat_animation_player = $heat_AnimationPlayer
var player_death_effect = preload("res://playerdeatheffect.tscn")
@export var jump_count : int = 1

const GRAVITY = 5000
@export var speed : int = 800
@export var jump : int = -270
@export var JUMP_HORIZONTAL_speed : int = 100
@export var Max_JUMP_HORIZONTAL_speed : int = 100
@export var slow_down_speed : int = 1000
enum  state { idle , run , jump , shot }
var current_jump_count : int

var current_state = state 
var mazule_position

func _ready():
	current_state = state.idle
	mazule_position = mazule.position
	
	
func _physics_process(delta : float):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	player_shooting(delta)
	player_mazule_direction()
	move_and_slide()
	
	player_animations()
	
func player_falling(delta : float):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
@warning_ignore("unused_parameter")
func player_idle(delta : float):
	if is_on_floor():
		current_state = state.idle
		#print("state:", state.keys()[current_state])
		
func player_run(delta : float):
		
		var direction = Input.get_axis("move_left", "move_right")
		
		if direction:
			velocity.x += direction  * speed * delta
			velocity.x = clamp(velocity.x, -Max_Horizontal_Speed, Max_Horizontal_Speed)
		else:
			velocity.x = move_toward(velocity.x, 0, slow_down_speed * delta)
		if direction != 0:
			current_state = state.run
			#print("state:", state.keys()[current_state])
			animated_sprite_2d.flip_h = false if direction > 0 else true
			
func player_jump(delta : float):
	var jump_input : bool = Input.is_action_just_pressed("jump_up")
		
	if is_on_floor() and jump_input:
		current_jump_count = 0
		velocity.y = jump
		current_jump_count += 1
		current_state = state.jump
		
	if !is_on_floor() and jump_input and current_jump_count < jump_count:
		velocity.y = jump
		current_jump_count += 1
		current_state = state.jump
		
	if  !is_on_floor() and current_state == state.jump:
		var direction = Input.get_axis("move_left", "move_right")
		#print("state:", state.keys()[current_state])
		velocity.x += direction +  JUMP_HORIZONTAL_speed * delta
		velocity.x = clamp(velocity.x, -Max_JUMP_HORIZONTAL_speed, Max_JUMP_HORIZONTAL_speed)

func player_shooting(delta : float):
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0 and Input.is_action_just_pressed("shout"):
		var bullet_instance = bullet.instantiate() as Node2D
		bullet_instance.direction = direction
		bullet_instance.global_position = mazule.global_position
		get_parent().add_child(bullet_instance)
		current_state = state.shot
		#print("state:", state.keys()[current_state])
func player_mazule_direction():
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction  > 0:
		mazule.position.x = mazule_position.x
	elif direction < 0:
		mazule.position.x = -mazule_position.x

	
func player_animations():
	if current_state == state.idle:
		animated_sprite_2d.play("idle")
	elif current_state == state.run and animated_sprite_2d.animation != "run_shout":
		animated_sprite_2d.play("run")
	elif current_state == state.jump:
		animated_sprite_2d.play("jump")
	elif current_state == state.shot:
		animated_sprite_2d.play("run_shout")

func player_death():
	var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	player_death_effect_instance.global_position = global_position
	get_parent().add_child(player_death_effect_instance)
	queue_free()

func _on_health_bar_body_entered(body : Node2D):
	if body.is_in_group("menion"):
		print("enemy entered", body.damage_amount)
		heat_animation_player.play("heat")
		HealthManager.decreace_health(body.damage_amount)
		
	if HealthManager.current_health <= 0:
		player_death()


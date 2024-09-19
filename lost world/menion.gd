extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var enemy_death_effect = preload("res://enemy_death_effect.tscn")
@export var patrolpoint : Node
var health_amount : int = 3
@export var damage_amount : int = 1

const GRAVITY = 3000
const speed = 3000
enum state { walk, idle }
var current_state = state
var direction : Vector2 = Vector2.LEFT
var number_of_points : int
var point_position : Array[Vector2]
var current_point : Vector2
var current_point_position : int


func _ready():
	if patrolpoint != null:
		number_of_points = patrolpoint.get_children().size()
		for points in patrolpoint.get_children():
			point_position.append(points.global_position)
		current_point = point_position[current_point_position]
	else:
		print("No pertrol point")
			
	current_state = state.idle
	
func _physics_process(delta : float):
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	anime_animation()
	
	move_and_slide()

func enemy_gravity(delta : float):
	velocity.y += GRAVITY * delta
	
func enemy_idle(delta : float):
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		current_state = state.idle
	
func enemy_walk(delta : float):
		
	if abs(position.x -current_point.x) > 0.5:
		velocity.x = direction.x * speed * delta
		current_state = state.walk
	else:
		current_point_position += 1
		
	if current_point_position == number_of_points:
		current_point_position = 0
		
	current_point = point_position[current_point_position]
	
	if current_point.x > position.x:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
	animated_sprite_2d.flip_h = direction.x > 0

func anime_animation():
	if current_state == state.idle:
		animated_sprite_2d.play("idle")
	elif current_state == state.walk:
		animated_sprite_2d.play("walk")


func _on_area_2d_area_entered(area : Area2D):
	print("area entered")
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		health_amount -= node.damage_amount
		print("health_amount:", health_amount)
		
		if health_amount == 0 :
			var enemy_death_effect_instance = enemy_death_effect.instantiate() as Node2D
			enemy_death_effect_instance.global_position = global_position
			get_parent().add_child(enemy_death_effect_instance)
			queue_free()
		

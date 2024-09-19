extends Node

var max_health : int = 3
var current_health : int

signal on_health_change

func _ready():
	current_health = max_health
func decreace_health(health_amount : int):
	current_health -= health_amount
	
	if current_health < 0:
		current_health = 0
	print("decreace_health called")
	on_health_change.emit(current_health)
	
func increase_health(health_amount: int):
	current_health += health_amount  # Add the passed health amount, not max_health
	# Ensure that current_health does not exceed max_health
	if current_health > max_health:
		current_health = max_health

	print("increase_health called") 
		

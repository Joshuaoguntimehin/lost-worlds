class_name NodeFiniteStateMachine
extends Node

@export var initial_node_state: Nodestate

var node_states: Dictionary = {}
var current_node_state: Nodestate
var current_node_state_name: String

func _ready():
	for child in get_children():
		if child is Nodestate:
			node_states[child.name.to_lower()] = child
			
	if initial_node_state:
		initial_node_state.enter()
		current_node_state = initial_node_state
	
func _process(delta : float):
	if current_node_state:
		current_node_state.on_process(delta)
func _physics_process(delta : float):
	if current_node_state:
		current_node_state.on_physics_process(delta)
	print("current state:", current_node_state.name.to_lower())
	
func transition_to(node_state_name: String):
	if node_state_name.to_lower() == str(current_node_state.name).to_lower():
		return
	var new_node_state = node_states.get(node_state_name.to_lower())
	if !new_node_state:
		return
		
	
		
	if current_node_state:
		current_node_state.exit()
		
	current_node_state = new_node_state
	current_node_state_name = node_state_name.to_lower() 

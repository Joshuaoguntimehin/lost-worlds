extends Node
@export var node_finite_state_machine : NodeFiniteStateMachine



func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("player"):
		print("Player entered Area 2D")
		node_finite_state_machine.transition_to("attack")

func _on_area_2d_body_exited(body: Node2D):
	if body.is_in_group("player"):
		print("Player exited Area 2D")
		node_finite_state_machine.transition_to("idle")

func _on_area_2d_2_body_entered(body: Node2D):
	if body.is_in_group("player"):
		print("Player entered Area 2D_2")
		node_finite_state_machine.transition_to("attack")

func _on_area_2d_2_body_exited(body: Node2D):
	if body.is_in_group("player"):
		print("Player exited Area 2D_2")
		node_finite_state_machine.transition_to("idle")

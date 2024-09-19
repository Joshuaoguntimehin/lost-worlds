extends Node

static var total_award_amount : int

signal on_collectible_award_received


func give_pickup_amount(collectable_amount : int):
	total_award_amount += collectable_amount
	
	on_collectible_award_received.emit(total_award_amount)
	

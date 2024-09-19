extends Node
var  Inventory : Dictionary

func add_is_inventory(type : String, value : String):
	Inventory[type] = value
	
	
func has_inventory_item(value : String) -> bool:
	if value == null:
		return false
	
	var item = Inventory.find_key(value)
	
	if item:
		return true
	
	return false
	

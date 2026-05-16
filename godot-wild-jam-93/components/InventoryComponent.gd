extends Node
class_name InventoryComponent

var inventory : Dictionary[String, ItemData]

func get_item(key : String) -> ItemData:
	if key not in inventory:
		return null

	return inventory[key]

func add_item(item : ItemData) -> void:
	if item.item_name not in inventory:
		inventory[item.item_name] = item
	else:
		inventory[item.item_name].stack_amount += item.stack_amount

func pull_item(key : String) -> ItemData:
	if key not in inventory:
		return null

	if inventory[key].stack_amount > 1:
		inventory[key].stack_amount -= 1
		var item_data := inventory[key]
		return item_data
	else:
		var item_data := inventory[key]
		inventory.erase(key)
		return item_data

extends Node
class_name ResourceCollectionComponent

var resources : Dictionary[String, ResourceData]

func pick_up(data : ResourceData) -> void:
	var key := "%d-%d" % [data.resource_type, data.resource_level]
	if key in resources:
		resources[key].resource_amount += data.resource_amount
	else:
		resources[key] = data

func spend(key : String, value : int) -> bool:
	if key not in resources:
		return false

	if resources[key].resource_amount < value:
		return false

	resources[key].resource_amount -= value

	return true

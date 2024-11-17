extends Node
var inventory: Array = ["0"]
func _ready() -> void:
	pass

func _process(_delta) -> void:
	pass

func add_item(itemID) -> void:
	inventory.append(itemID)

func getInv() -> Array:
	return inventory

func checkForID(ID: String):
	if ID in self.inventory:
		return true
	else:
		return false

extends Node

var locationStack: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func push(item):
	locationStack.append(item)
	
func pop() -> Variant:
	if locationStack.size() > 0:
		return locationStack.pop_back()
	else:
		print("Stack is empty!")
		return null

func peek() -> Variant:
	if locationStack.size() > 0:
		return locationStack[locationStack.size() - 1]
	else:
		return null
		
func size() -> int:
	return locationStack.size()
		
		
		
		
		
		
		
		

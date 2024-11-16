extends Sprite2D

class_name InvItem
@export var description = ""
var descriptionBox = load("res://Scenes/Inventory/descriptionBox.tscn").instantiate()

func _on_inv_slot_mouse_entered() -> void: 
	var box = descriptionBox
	add_child(box)


func _on_inv_slot_mouse_exited() -> bool:
	if get_children().size() > 0:
		remove_child(descriptionBox)
	return true

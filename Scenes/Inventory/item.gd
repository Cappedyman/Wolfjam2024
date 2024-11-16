extends Sprite2D

class_name InvItem
@export var description = ""
var descriptionBox = load("res://Scenes/Inventory/descriptionBox.tscn").instantiate()




func _on_inv_slot_mouse_entered() -> void: 
	add_child(descriptionBox)

#
func _on_inv_slot_mouse_exited() -> void:
	remove_child(descriptionBox)

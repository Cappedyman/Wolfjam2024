extends Sprite2D

@export var description = ""

func _ready() -> void:
	self.texture = load("res://Images/ItemSlotActive.png")
	
 
func _on_button_toggled(toggled_on: bool) -> void:	
	
	if toggled_on:
		self.texture = load("res://Images/ItemSlotActive.png")
	
	else:
		self.texture = load("res://Images/ItemSlot.png")



	

extends Sprite2D

@export var description = ""

func _ready() -> void:
	self.texture = load("res://Images/ItemSlotActive.png")
	
 
func _on_button_toggled(toggled_on: bool) -> void:	
	#var default_viewport = get_viewport()
	#print(default_viewport.size)
	#print(catPosition.x)
	#$InvUi.position = Vector2(catPosition.x - default_viewport.size.x + 900,  default_viewport.size.y - 600)

	if toggled_on:
		self.texture = load("res://Images/ItemSlotActive.png")
	
	else:
		self.texture = load("res://Images/ItemSlot.png")



	

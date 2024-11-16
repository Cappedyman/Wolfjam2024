extends Control

# on the ready call preload the dictionary
@onready var inventory = StaticInventory.inventory
# get the rect slots
@onready var slots: Array = $InventoryMasterBox/ItemBoxes.get_children()

var isOpen = false
var inventoryActive = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# When inventory is opened pauses game
	update_slots()
	process_mode = Node.PROCESS_MODE_ALWAYS
	close()

	

# populates inventory
func update_slots():
	for i in range(min(inventory.size(), slots.size())):
		var childrens = slots[i].get_children()[1]
		var item_dict = StaticData.get_item_dict_by_id(inventory[i])
		childrens.texture = load(item_dict["image"])
		childrens.name = item_dict["name"]
		childrens.description = item_dict["description"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	

func _input(event: InputEvent) -> void:
	# open and close inventory
	if Input.is_action_just_pressed("openInventory"):
		if isOpen and inventoryActive:
			close()
		else:
			open()
			inventoryActive = true
			_on_inventory_button_pressed()

			
	# open and close quests
	if Input.is_action_just_pressed("OpenQuest"):
		if isOpen and not inventoryActive:
			close()
		else:
			open()
			inventoryActive = false
			_on_quest_button_pressed()
	if Input.is_action_just_pressed("Exit") and isOpen:
		close()
	
func open():
	# sets quest/inventory window to visible
	self.visible = true
	# pauses game when inventory open
	get_tree().paused = true
	isOpen = true


func close():
	visible = false
	get_tree().paused = false
	isOpen = false

# toggles button colors and visibility of the quest/ inventory menus 
func _on_quest_button_pressed() -> void:
	$QuestButton/questButton.button_pressed = true
	$InventoryButton/inventoryButton.button_pressed = false
	$InventoryMasterBox/ItemBoxes.visible = false
	$InventoryMasterBox/QuestList.visible = true
	$InventoryButton/inventoryButton.z_index = 0
	$QuestButton/questButton.z_index = 2
	$InventoryButton/InventoryLabel.add_theme_color_override("font_shadow_color", Color(0,0,0,0))
	$QuestButton/QuestsLabel.add_theme_color_override("font_shadow_color", Color(0,0,0,1))
	
func _on_inventory_button_pressed() -> void:
	$InventoryButton/inventoryButton.button_pressed = true
	$QuestButton/questButton.button_pressed = false
	$InventoryMasterBox/ItemBoxes.visible = true
	$InventoryMasterBox/QuestList.visible = false
	$InventoryButton/inventoryButton.z_index = 2
	$QuestButton/questButton.z_index = 0
	$InventoryButton/InventoryLabel.add_theme_color_override("font_shadow_color", Color(0,0,0,1))
	$QuestButton/QuestsLabel.add_theme_color_override("font_shadow_color", Color(0,0,0,0))

# handles physical press of close button
func _on_close_button_button_up() -> void:
	close()

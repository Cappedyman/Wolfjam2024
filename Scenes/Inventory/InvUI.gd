extends Control

@onready var inventory: Dictionary = {}
@onready var slots: Array = []

var isOpen = false
var inventoryActive = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# When inventory is opened pauses game
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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

func _on_close_button_button_up() -> void:
	close()

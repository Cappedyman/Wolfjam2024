extends Node2D

var canEnterFishDoor: bool = false
var canEnterAlleywayDoor: bool = false
var canEnterPharmacyDoor: bool = false
var canEnter711Door: bool = false

var canTalkToFlowerLady: bool = false;
var canTalkToFishMonger: bool = false;
var canTalkToHopelessRomantic: bool = false;
var canTalkToDepressedNick: bool = false;

@onready var Cat = get_node("Cat")
@onready var interactIconScene = load("res://Scenes/InteractIcon/InteractIcon.tscn")
@onready var dialogueBox = load("res://Scenes/Dialogue/dialogue.tscn")

var catPosition: Vector2
var interactIcon
var camera 
var dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create and attach the interact icon
	interactIcon = interactIconScene.instantiate()
	add_child(interactIcon)
	hideInteractIcon()

	# Create and attach the Camera2D to the Cat
	camera = Camera2D.new()
	Cat.add_child(camera)
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_bottom = 190
	camera.limit_right = 5000
	
	if StaticInventory.checkForID("2"):
		$Rose.queue_free()
	

	match LocationStack.peek():
		"FishDoor":
			Cat.position = Vector2(2500, 500)
			print("fish spawn")
		"AlleywayDoor":
			Cat.position = Vector2(3000, 500)
			print("alleyway spawn")
		"PharmacyDoor":
			Cat.position = Vector2(4747, 500)
			print("pharmacy spawn")
		"711Door":
			Cat.position = Vector2(3500, 500)
			print("711 spawn")
			
	catPosition = Cat.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	catPosition = Cat.position
	print("Cat's current position:", catPosition)
	
	# Update position of the menu
	$InvUi.position = Vector2(Cat.position.x - 200, Cat.position.y - 450 )
	
	if canEnterFishDoor:
		var fishDoorPosition = $FishDoor.position
		interactIcon.position = Vector2(fishDoorPosition.x, fishDoorPosition.y - 150)
		showInteractIcon()
		if Input.is_action_just_pressed("Interact"):
			LocationStack.push("FishDoor")
			get_tree().change_scene_to_file("res://Scenes/FishStore/FishStore.tscn")
		
	if canEnterAlleywayDoor:
		var alleywayDoorPosition = $AlleywayDoor.position
		interactIcon.position = Vector2(alleywayDoorPosition.x, alleywayDoorPosition.y - 150)
		showInteractIcon()
		if Input.is_action_just_pressed("Interact"):
			LocationStack.push("AlleywayDoor")
			get_tree().change_scene_to_file("res://Scenes/Alleyway/Alleyway.tscn")
		
	if canEnterPharmacyDoor:
		var medDoorPos = $PharmacyDoor.position
		interactIcon.position = Vector2(medDoorPos.x, medDoorPos.y - 150)
		showInteractIcon()
		if Input.is_action_just_pressed("Interact"):
			LocationStack.push("PharmacyDoor")
			get_tree().change_scene_to_file("res://Scenes/Pharmacy/Pharmacy.tscn")
		
	if canEnter711Door:
		var slushyPlaceDoorPos = $"711Door".position
		interactIcon.position = Vector2(slushyPlaceDoorPos.x, slushyPlaceDoorPos.y - 150)
		showInteractIcon()
		if Input.is_action_just_pressed("Interact"):
			LocationStack.push("711Door")
			get_tree().change_scene_to_file("res://Scenes/711/711.tscn")

	if canTalkToFishMonger and Input.is_action_just_pressed("Interact"): # Dialogue for fish-guy
		get_tree().paused = true
		renderDialogueBox("fish-guy")
		dialogue.process_mode = Node.PROCESS_MODE_ALWAYS # allows background to be frozen while dialogue plays

	if canTalkToFlowerLady and Input.is_action_just_pressed("Interact"): # Dialogue for fleurist
		get_tree().paused = true
		renderDialogueBox("fleurist")
		dialogue.process_mode = Node.PROCESS_MODE_ALWAYS # allows background to be frozen while dialogue plays

	if canTalkToHopelessRomantic and Input.is_action_just_pressed("Interact"): # Dialogue for couple
		get_tree().paused = true
		renderDialogueBox("couple")
		dialogue.process_mode = Node.PROCESS_MODE_ALWAYS # allows background to be frozen while dialogue plays

	if canTalkToDepressedNick and Input.is_action_just_pressed("Interact"): # Dialogue for depressed-man
		get_tree().paused = true
		renderDialogueBox("depressed-man")
		dialogue.process_mode = Node.PROCESS_MODE_ALWAYS # allows background to be frozen while dialogue plays

func renderDialogueBox(name: String) -> void:
	dialogue = dialogueBox.instantiate()
	var cat = get_node("Cat")
	dialogue.position = Vector2(cat.position.x - 300, cat.position.y - 250)
	
	var questItem
	match name:
		"fish-guy":
			questItem = "fish"
		"fleurist":
			questItem = "rose"
		"couple":
			questItem = "rose"
		"depressed-man":
			questItem = "antidepressants"
	
	if StaticInventory.checkForID(StaticData.get_item_id_by_name(questItem)) and StaticQuestProgress.getProgression(name) == 1:
		StaticQuestProgress.progressQuest(name)
	
	dialogue.setNpc(name) # assigns proper dialogues
	dialogue.create_queue() # creates the output queue for the dialogue box
	
	add_child(dialogue)

func _dialogue_finished(name: String):
	dialogue.queue_free()
	get_tree().paused = false
	if name.to_lower() != "fleurist":
		if StaticQuestProgress.getProgression(name) == 0 or StaticQuestProgress.getProgression(name) == 2:
			StaticQuestProgress.progressQuest(name)

func showInteractIcon() -> void:
	interactIcon.visible = true

func hideInteractIcon() -> void:
	interactIcon.visible = false

# Door interaction signals
func _on_fish_door_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterFishDoor = true 

func _on_fish_door_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterFishDoor = false
		hideInteractIcon()

func _on_alleyway_door_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterAlleywayDoor = true

func _on_alleyway_door_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterAlleywayDoor = false
		hideInteractIcon()

func _on_pharmacy_door_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterPharmacyDoor = true

func _on_pharmacy_door_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterPharmacyDoor = false
		hideInteractIcon()

func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canEnter711Door = true

func _on_door_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canEnter711Door = false
		hideInteractIcon()

func _on_rose_body_entered(body: Node2D) -> void:
	StaticInventory.add_item("2")
	$Rose.queue_free()
	print(StaticInventory.getInv())
	





func _on_fish_monger_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canTalkToFishMonger = true

func _on_fish_monger_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canTalkToFishMonger = false


func _on_flower_lady_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canTalkToFlowerLady = true


func _on_flower_lady_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canTalkToFlowerLady = false


func _on_nick_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canTalkToDepressedNick = true


func _on_nick_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canTalkToDepressedNick = false


func _on_couple_man_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canTalkToHopelessRomantic = true


func _on_couple_man_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canTalkToHopelessRomantic = false
		
		

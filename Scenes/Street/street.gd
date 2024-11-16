extends Node2D

var canEnterFishDoor: bool = false
var canEnterAlleywayDoor: bool = false
var canEnterPharmacyDoor: bool = false
var canEnter711Door: bool = false

@onready var Cat = get_node("Cat")
@onready var interactIconScene = load("res://Scenes/InteractIcon/InteractIcon.tscn")

var interactIcon
var camera # Camera2D variable to store the camera instance

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


	match LocationStack.peek():
		"FishDoor":
			Cat.position = Vector2(480, 440)
			print("fish spawn")
		"AlleywayDoor":
			print("alleyway spawn")
		"PharmacyDoor":
			print("pharmacy spawn")
		"711Door":
			print("711 spawn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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

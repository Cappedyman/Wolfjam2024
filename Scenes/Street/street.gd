extends Node2D

var canEnterFishDoor: bool = false
var canEnterAlleywayDoor: bool = false
var canEnterPharmacyDoor: bool = false
var canEnter711Door: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canEnterFishDoor and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/FishStore/FishStore.tscn");
		
	if canEnterAlleywayDoor and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/Alleyway/Alleyway.tscn");
		
	if canEnterPharmacyDoor and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/Pharmacy/Pharmacy.tscn");
		
	if canEnter711Door and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/711/711.tscn");






func _on_fish_door_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterFishDoor = true 
		

func _on_fish_door_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterFishDoor = false




func _on_alleyway_door_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterAlleywayDoor = true


func _on_alleyway_door_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterAlleywayDoor = false




func _on_pharmacy_door_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterPharmacyDoor = true


func _on_pharmacy_door_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterPharmacyDoor = false




func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		canEnter711Door = true


func _on_door_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canEnter711Door = false

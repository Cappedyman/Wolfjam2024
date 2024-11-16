extends Node2D

var canEnterPharmacyDoor: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canEnterPharmacyDoor and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/Street/Street.tscn");




func _on_pharmacy_door_reverse_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canEnterPharmacyDoor = true 


func _on_pharmacy_door_reverse_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
			canEnterPharmacyDoor = false

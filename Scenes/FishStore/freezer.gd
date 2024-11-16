extends Node2D

@onready var interactIconScene = load("res://Scenes/InteractIcon/InteractIcon.tscn")

var interactIcon
var canEnterFishDoor: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactIcon = interactIconScene.instantiate()
	add_child(interactIcon)
	hideInteractIcon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canEnterFishDoor:
		var fishDoorPosition = $FreezerDoorReverse.position
		interactIcon.position = Vector2(fishDoorPosition.x, fishDoorPosition.y - 150)
		showInteractIcon()
		if Input.is_action_just_pressed("Interact"):
			get_tree().change_scene_to_file("res://Scenes/Street/Street.tscn");


func showInteractIcon() -> void:
	interactIcon.visible = true

func hideInteractIcon() -> void:
	interactIcon.visible = false



func _on_freezer_door_reverse_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canEnterFishDoor = true 

func _on_freezer_door_reverse_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		canEnterFishDoor = false
		hideInteractIcon()

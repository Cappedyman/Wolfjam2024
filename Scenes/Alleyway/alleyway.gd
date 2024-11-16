extends Node2D

var canEnterAlleywayDoor: bool = false
var canTalkToHobo: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canEnterAlleywayDoor and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/Street/Street.tscn");
		
	if canTalkToHobo and Input.is_action_just_pressed("Interact"):
		var mystring: String = StaticData.get_dialogue_id_by_name("hobo")
		print(mystring)
		
		print(StaticData.dialogueData[mystring]["name"])



func _on_alleyway_door_reverse_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canEnterAlleywayDoor = true 


func _on_alleyway_door_reverse_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
			canEnterAlleywayDoor = false




func _on_hobo_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canTalkToHobo = true


func _on_hobo_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
			canTalkToHobo = false

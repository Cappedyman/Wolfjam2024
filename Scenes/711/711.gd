extends Node2D

var canEnter711Door: bool = false
var canTalkToMoneyMan: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canEnter711Door and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/Street/Street.tscn");

	if canTalkToMoneyMan and Input.is_action_just_pressed("Interact"):
		pass



func _on_door_reverse_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canEnter711Door = true 


func _on_door_reverse_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
			canEnter711Door = false



func _on_moneyman_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canTalkToMoneyMan = true


func _on_moneyman_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
			canTalkToMoneyMan = false


func _on_id_card_body_entered(body: Node2D) -> void:
	StaticInventory.add_item("3")
	$IDCard.queue_free()

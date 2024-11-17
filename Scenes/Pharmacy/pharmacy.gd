extends Node2D

var canEnterPharmacyDoor: bool = false
var canTalkToMoneyMan: bool = false

var dialogue

@onready var dialogueBox = load("res://Scenes/Dialogue/dialogue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canEnterPharmacyDoor and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/Street/Street.tscn");
		
	if canTalkToMoneyMan and Input.is_action_just_pressed("Interact") and StaticQuestProgress.depressedQuest == 1:
		get_tree().paused = true
		renderDialogueBox()
		dialogue.process_mode = Node.PROCESS_MODE_ALWAYS # allows background to be frozen while dialogue plays

func renderDialogueBox() -> void:
	dialogue = dialogueBox.instantiate()
	var cat = get_node("Cat")
	dialogue.position = Vector2(cat.position.x - 300, cat.position.y - 250)
	
	dialogue.setNpc("pharmasist") # assigns proper dialogues
	dialogue.create_queue() # creates the output queue for the dialogue box
	
	add_child(dialogue)

func _dialogue_finished(name: String):
	dialogue.queue_free()
	get_tree().paused = false
	
	StaticQuestProgress.progressQuest("depressed-man")

func _on_pharmacy_door_reverse_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canEnterPharmacyDoor = true 


func _on_pharmacy_door_reverse_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
			canEnterPharmacyDoor = false


func _on_money_man_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canTalkToMoneyMan = true


func _on_money_man_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
			canTalkToMoneyMan = false

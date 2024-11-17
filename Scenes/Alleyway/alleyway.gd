extends Node2D

var canEnterAlleywayDoor: bool = false
var canTalkToHobo: bool = false

var dialogue
var interactIcon

@onready var dialogueBox = load("res://Scenes/Dialogue/dialogue.tscn")
@onready var interactIconScene = load("res://Scenes/InteractIcon/InteractIcon.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactIcon = interactIconScene.instantiate()
	add_child(interactIcon)
	hideInteractIcon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canEnterAlleywayDoor and StaticQuestProgress.hoboQuest == 3:
		var doorPos = $AlleywayDoorReverse.position
		interactIcon.position = Vector2(doorPos.x, doorPos.y - 150)
		showInteractIcon()
		if Input.is_action_just_pressed("Interact"):
			get_tree().change_scene_to_file("res://Scenes/Street/Street.tscn");
		
	if canTalkToHobo and Input.is_action_just_pressed("Interact"):
		get_tree().paused = true
		renderDialogueBox()
		dialogue.process_mode = Node.PROCESS_MODE_ALWAYS
		
	if StaticInventory.checkForID("0"):
		if $Key:
			$Key.queue_free()


func renderDialogueBox() -> void:
	dialogue = dialogueBox.instantiate()
	var cat = get_node("Cat")
	dialogue.position = Vector2(cat.position.x - 300, cat.position.y)
	
	if StaticInventory.checkForID(StaticData.get_item_id_by_name("key")) and StaticQuestProgress.hoboQuest == 0:
		StaticQuestProgress.progressQuest("hobo")
	
	dialogue.setNpc("hobo") # assigns proper dialogues
	dialogue.create_queue() # creates the output queue for the dialogue box
	
	add_child(dialogue)

func _dialogue_finished(name: String):
	dialogue.queue_free()
	get_tree().paused = false
	if StaticQuestProgress.hoboQuest == 0 or StaticQuestProgress.hoboQuest == 2: # we just got the quest or just finished it
		StaticQuestProgress.progressQuest("hobo")

func _on_alleyway_door_reverse_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canEnterAlleywayDoor = true 


func _on_alleyway_door_reverse_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
			canEnterAlleywayDoor = false
			hideInteractIcon()
			

func _on_hobo_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
			canTalkToHobo = true


func _on_hobo_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
			canTalkToHobo = false
	

func showInteractIcon() -> void:
	interactIcon.visible = true

func hideInteractIcon() -> void:
	interactIcon.visible = false


func _on_key_body_entered(body: Node2D) -> void:
	StaticInventory.add_item("0")
	StaticQuestProgress.progressQuest("hobo")
	$Key.queue_free()

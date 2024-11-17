extends Control

@onready var _name: Label = $Box/Name
@onready var _dialogueText: Label = $Box/DialogueText
@onready var _imageText: Sprite2D = $Box/Image/Sprite2D

# tells us what stage in the quest we are
var questProgress: int = -1

var dialogueDict = {}

var outputQueue = []

var init: bool = true # tells us if we are in init

func _process(_delta: float) -> void:
	if not init: # if we are out of initialization, then we push the first piece of dialogue and never run _process again
		_name.text = outputQueue.pop_front()["name"]
		_dialogueText.text = outputQueue.pop_front()
		init = !init

# button will progress dialogue // change image and name
func _on_continue_button_up() -> void:
	var nextCommand = outputQueue.pop_front()
	if nextCommand is Dictionary: # change image and name
		_name.text = nextCommand["name"]
		_dialogueText.text = outputQueue.pop_front() #if we just changed the name then the next command will be a String
		_imageText.texture = load(nextCommand["image"]) 
	elif nextCommand is String:   # change dialogue
		_dialogueText.text = nextCommand
	else:                         # signals end of dialogue
		get_parent()._dialogue_finished(dialogueDict["name"])

func setSpeaker(info: Dictionary) -> void: # Changes speakers name and Photo
	_name.text = info["name"]

func setNpc(name: String) -> void:
	var npcID = StaticData.get_dialogue_id_by_name(name)
	dialogueDict = StaticData.get_dialogue_dict_by_id(npcID)
	questProgress = StaticQuestProgress.getProgression(name)

func create_queue() -> void:
	if dialogueDict["name"].to_lower() == "fleurist":
		questProgress = StaticQuestProgress.coupleQuest # fleurist follows same progression as couple
	if dialogueDict["name"].to_lower() == "pharmasist":
		questProgress = StaticQuestProgress.depressedQuest #Pharmasist follows same progression as depressed-man
	
	match questProgress:
		0:
			outputQueue = lex(dialogueDict["pre-quest-dialogue"])
		1:
			outputQueue = lex(dialogueDict["during-quest-dialogue"])
		2:
			outputQueue = lex(dialogueDict["post-quest-dialogue"])
		3:
			outputQueue = lex(dialogueDict["residual-dialogue"])
	init = false # end dialogue initizilation

# lex build's an ouput queue to tell the dialogue box what to do next
func lex(dialogue: String) -> Array:
	var queue = []
	var ignore: bool = false
	var dialogueBuilder: String = ""

	for ch in dialogue:
		if not ignore: # we need to ignore the character to handle it differently if the previous character was a '@'
			match ch:
				'@': # we are going to switch photo and name, ignore it so we can handle it specifically
					ignore = true
				'\n': # new line, we add the current string to the queue and start a new string
					queue.push_back(dialogueBuilder)
					dialogueBuilder = ""
				_: # Any non-special character we will add to the dialogue builder
					dialogueBuilder += ch
		else:
			if ch == 'n': # we switch to the npc's image and name
				queue.push_back({"name": dialogueDict["name"], "image": dialogueDict["image"]})
			else:         # we switch to the cat's image and name
				queue.push_back({"name": "Cat", "image": "res://Art/People/PeopleDialogueBox/cat-dbox.png"})
			ignore = false; # reset the tag search
	
	if !dialogueBuilder.is_empty(): # appends final bit of dialogue if applicable
		queue.push_back(dialogueBuilder)
	
	queue.push_back(0) # identifier to tell the dialog box to unpause game tree and free itself // progess, it will be the only int in the queue
	return queue

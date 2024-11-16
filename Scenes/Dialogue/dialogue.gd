extends Control

@onready var _name: Label = $Box/Name
@onready var _dialogueText: Label = $Box/DialogueText

# tells us what stage in the quest we are
var questProgress: int = -1

var dialogueDict = {}

var outputQueue = []

var init: bool = true # tells us if we are in init

func _process(_delta: float) -> void:
	if not init: # if we are out of initialization
		pass
	
	
func setSpeaker(info: Dictionary) -> void: # Changes speakers name and Photo
	_name.text = info["name"]

func setNpc(name: String) -> void:
	var npcID = StaticData.get_dialogue_id_by_name(name)
	dialogueDict = StaticData.get_dialogue_dict_by_id(npcID)
	questProgress = StaticQuestProgress.getProgression(name)

func create_queue() -> void:
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
				queue.push_back({"name": dialogueDict["name"]})
			else:         # we switch to the cat's image and name
				queue.push_back({"name": "Cat"})
			ignore = false; # reset the tag search
	
	if !dialogueBuilder.is_empty(): # appends final bit of dialogue if applicable
		queue.push_back(dialogueBuilder)
	
	queue.push_back("{signal-done}") # identifier to tell the dialog box to unpause game tree and free itself // progess
	return queue

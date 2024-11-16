extends Node

#stores all data for a given quest item
var itemData = {}

#stores all data for dialogues
var dialogueData = {}

var dialogueDataFilePath = "res://Data/Dialogue/dialogue.json"
var itemDataFilePath = "res://Data/Items/items.json"

func _ready() -> void:
	dialogueData = load_data_file(dialogueDataFilePath)
	itemData = load_data_file(itemDataFilePath)

func load_data_file(filePath : String):
	if !FileAccess.file_exists(filePath): #no file exists with the given path
		print(filePath + " doesn't exist")
	else:
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Error reading " + filePath)

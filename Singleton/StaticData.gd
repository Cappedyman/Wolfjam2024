extends Node

#stores all data for a given quest item
var itemData = {}

#stores all data for dialogues
var dialogueData = {}

#stores mapping for dialogue name to id
var dialogueMapping = {
	"hobo": "0",
	"fish-guy": "1",
	"couple": "2",
	"depressed-man": "3",
	"cashier": "4",
	"pharmasist": "5",
	"fleurist": "6"
}

#stores mapping for item name to id
var itemMapping = {
	"key": "0",
	"fish": "1",
	"rose": "2",
	"id": "3",
	"antidepressants": "4"
}

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

func get_dialogue_id_by_name(name: String) -> String:
	if name.to_lower() in dialogueMapping:
		return dialogueMapping[name.to_lower()]
	else:
		return "null"

func get_item_id_by_name(name: String) -> String:
	if name.to_lower() in itemMapping:
		return itemMapping[name.to_lower()]
	else:
		return "null"

func get_item_dict_by_id(id: String) -> Dictionary:
	if id not in itemData:
		print(id + " is not a valid item id")
		return {null: null}
	else:
		return itemData[id]

func get_dialogue_dict_by_id(id: String) -> Dictionary:
	if id not in dialogueData:
		print(id + " is not a valid item id")
		return {null: null}
	else:
		return dialogueData[id]

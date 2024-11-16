extends Node

var hoboQuest: int

var fishQuest: int

var coupleQuest: int

var depressedQuest: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hoboQuest = 0
	fishQuest = 0
	coupleQuest = 0
	depressedQuest = 0

func progressQuest(name: String):
	match name.to_lower():
		"hobo":
			hoboQuest += 1
		"fish-guy":
			fishQuest += 1
		"couple":
			coupleQuest += 1
		"depressed-man":
			depressedQuest += 1
		_:
			print("Quest: " + name + " does not exist")

func getProgression(name: String) -> int:
	match name.to_lower():
		"hobo":
			return hoboQuest
		"fish-guy":
			return fishQuest
		"couple":
			return coupleQuest
		"depressed-man":
			return depressedQuest
		_:
			print("Quest: " + name + " does not exist")
			return -1

# returns whether or not we are done with the game
func isDone() -> bool:
	return (hoboQuest == 3) && (fishQuest == 3) && (coupleQuest == 3) && (depressedQuest == 3)

extends Panel


func _ready():
	pass

func updateQuests():
	var quests = ["hobo", "fish-guy", "couple", "depressed-man"]
	var references = {"hobo": $HoboQuest, "fish-guy": $FishQuest, "couple": $CoupleQuest, "depressed-man": $DepressedQuest}
	for quest in quests:
		var prog_level = StaticQuestProgress.getProgression(quest)
		var ref = references[quest]
		match prog_level:
			0:
				ref.texture = load("res://Images/LockedQuest.png")
			1:
				ref.texture = load("res://Images/33.png")
			2:
				ref.texture = load("res://Images/66.png")
			3:
				ref.texture = load("res://Images/100.png")
				
				

	
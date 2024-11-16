extends Control

# tells us what stage in the quest we are
var questProgress: int = -1

var dialogueDict = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setNpc(name: String) -> void:
	var npcID = StaticData.get_dialogue_id_by_name(name)
	dialogueDict = StaticData.get_dialogue_dict_by_id(npcID)
	questProgress = StaticQuestProgress.getProgression(name)

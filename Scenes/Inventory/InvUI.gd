extends Control

var isOpen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("openInventory"):
		print("Inv opened")
		if isOpen:
			close()
		else:
			open()

func open():
	self.visible = true
	get_tree().paused = true
	isOpen = true

func close():
	visible = false
	get_tree().paused = false
	isOpen = false

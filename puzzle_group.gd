extends Node2D
class_name PuzzleGroup

@export var togglers : Array[Toggle]
@export var platforms : Array[Platform]
@export var use_child_nodes_order : bool = true
@export var one_shot_toggles: bool = true
var toggled : Array[Toggle]
signal toggle_group_solved

# Called when the node enters the scene tree for the first time.
func _ready():
	for platform in platforms:
		platform.togglers = togglers
		platform.wire_signals()
	for toggle in togglers:
		if one_shot_toggles:
			toggle.one_shot = true
		toggle.toggle_pressed.connect(toggle_pressed)
		toggle.toggle_released.connect(toggle_released)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func toggle_released(emiter):
	toggled.erase(emiter)

func toggle_pressed(emiter):
	toggled.append(emiter)
	if toggled == togglers:
		toggle_group_solved.emit()
	elif toggled.size() == togglers.size() and one_shot_toggles:
		toggled.clear()
		release_togglers()

func release_togglers():
	for toggle in togglers:
		toggle.release()

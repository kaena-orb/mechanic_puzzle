extends StaticBody2D
class_name Platform

@export var hide_on_success : bool
@export var puzzle_group : PuzzleGroup
@export var togglers : Array[Toggle]
var togglers_pressed : int
# Called when the node enters the scene tree for the first time.

func _ready():
	wire_signals()
	if not hide_on_success and togglers.size():
		hide_platform()


func wire_signals():
	for toggler in togglers:
		toggler.toggle_pressed.connect(enable)
		toggler.toggle_released.connect(disable)
	if puzzle_group:
		puzzle_group.toggle_group_solved.connect(enable)

func enable(_emitter = null):
	togglers_pressed += 1
	if togglers_pressed == togglers.size() or not togglers.size() and puzzle_group:
		if hide_on_success:
			hide_platform()
		else:
			show_platform()

func disable(_emitter = null):
	togglers_pressed -= 1
	if hide_on_success:
		show_platform()
	else:
		hide_platform()

func hide_platform():
	if not $CollisionShape2D.disabled:
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimationPlayer.play("hide")

func show_platform():
	$CollisionShape2D.set_deferred("disabled", false)
	$AnimationPlayer.play("show")

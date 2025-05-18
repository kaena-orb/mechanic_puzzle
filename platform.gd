extends StaticBody2D
class_name Platform

@export var hiddable : bool
@export var togglers : Array[Toggle]
var togglers_pressed : int
# Called when the node enters the scene tree for the first time.

func _ready():
	if hiddable:
		hide_platform()
	for toggler in togglers:
		toggler.toggle_pressed.connect(enable)
		toggler.toggle_released.connect(disable)

func enable():
	togglers_pressed += 1
	if togglers_pressed == togglers.size():
		$CollisionShape2D.set_deferred("disabled", false)
		$AnimationPlayer.play("show")

func disable():
	togglers_pressed -= 1
	hide_platform()

func hide_platform():
	if not $CollisionShape2D.disabled:
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimationPlayer.play("hide")

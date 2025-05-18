extends StaticBody2D
class_name Platform

@export var hiddable : bool
@export var togglers : Array[Toggle]
# Called when the node enters the scene tree for the first time.

func _ready():
	if hiddable:
		disable()
	for toggler in togglers:
		toggler.toggle_pressed.connect(enable)
		toggler.toggle_released.connect(disable)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func enable():
	$CollisionShape2D.set_deferred("disabled", false)
	$AnimationPlayer.play("show")

func disable():
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("hide")

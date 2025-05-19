extends StaticBody2D
class_name Toggle

var toggled : bool = false
var bodies_in_place : Array
var one_shot : bool = false
signal toggle_pressed(emiter)
signal toggle_released(emiter)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func release():
	$AnimationPlayer.play("RESET")
	toggle_released.emit(self)
	toggled = false


func add_body(body):
	if not toggled or not bodies_in_place.size():
		$AnimationPlayer.play("press")
		toggle_pressed.emit(self)
		toggled = true
	bodies_in_place.append(body)

func remove_body(body):
	bodies_in_place.erase(body)
	if not bodies_in_place.size() and not one_shot:
		release()
func _on_object_detection_area_entered(area):
	add_body(area)

func _on_object_detection_area_exited(area):
	remove_body(area)

func _on_object_detection_body_entered(body):
	add_body(body)

func _on_object_detection_body_exited(body):
	remove_body(body)

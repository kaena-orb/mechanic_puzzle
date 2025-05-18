extends StaticBody2D
class_name Toggle

var bodies_in_place : Array
signal toggle_pressed
signal toggle_released

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func toggle_on():
	pass

func add_body(body):
	if not bodies_in_place.size():
		$AnimationPlayer.play("press")
		toggle_pressed.emit()
	bodies_in_place.append(body)

func remove_body(body):
	bodies_in_place.erase(body)
	if not bodies_in_place.size():
		$AnimationPlayer.play("RESET")
		toggle_released.emit()

func _on_object_detection_area_entered(area):
	add_body(area)

func _on_object_detection_area_exited(area):
	remove_body(area)

func _on_object_detection_body_entered(body):
	add_body(body)

func _on_object_detection_body_exited(body):
	remove_body(body)

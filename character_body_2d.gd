extends CharacterBody2D

const PUSH_FORCE = 40.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var areas_close = []
var can_jump : bool = true

func _physics_process(delta):
	var grabbing = false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("grab"):
		if areas_close.size():
			var crate = areas_close[0].get_parent()
			crate.join_player(self)
			can_jump = false
	if Input.is_action_just_released("grab"):
		if areas_close.size():
			var crate = areas_close[0].get_parent()
			crate.drop()
			can_jump = true
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and can_jump:
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	for collider in get_slide_collision_count():
		var collisions = get_slide_collision(collider)
		if collisions.get_collider() is RigidBody2D:
			collisions.get_collider().apply_central_impulse(-collisions.get_normal() * PUSH_FORCE)


func _on_objects_area_entered(area):
	areas_close.append(area)


func _on_objects_area_exited(area):
	areas_close.erase(area)

func get_pinjoint():
	return $PinJoint2D

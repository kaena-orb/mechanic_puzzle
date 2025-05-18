extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func join_player(player: CharacterBody2D):
	if $GrooveJoint2D.global_position.x > player.global_position.x:
		$GrooveJoint2D.node_b = player.get_path()
	else:
		$GrooveJoint2D2.node_b = player.get_path()

func drop():
	$GrooveJoint2D2.node_b = ""
	$GrooveJoint2D.node_b = ""

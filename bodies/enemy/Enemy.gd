extends KinematicBody2D

const SCREEN_CENTER = Vector2(512, 300)
const SPEED = 80
var dir = Vector2.ZERO

export (PackedScene) var Particle
onready var Ship = get_tree().get_nodes_in_group("ship")[0]
func _physics_process(_delta):
	if Ship != null:
		if not Ship.dead:
			dir = (Ship.global_position - global_position).normalized() * SPEED
			rotation = atan2(dir.y, dir.x)
			dir = move_and_slide(dir)

func kill():
	var n = Particle.instance()
	n.emitting = true
	n.position = global_position
	n.play()
	get_parent().add_child(n)
	queue_free()
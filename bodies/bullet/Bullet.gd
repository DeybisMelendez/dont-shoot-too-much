extends Area2D
var direction = 0
const SPEED = 400

func _ready():
	$VisibilityNotifier2D.connect("screen_exited", self, "screen_exited")
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if body.is_in_group("enemy"):
		body.kill()
		var Ship = get_tree().get_nodes_in_group("ship")[0]
		Ship.add_point()
		queue_free()

func screen_exited():
	queue_free()

func _physics_process(delta):
	global_position += Vector2(cos(direction), sin(direction)) * SPEED * delta
extends Particles2D
export var kill_on_timeout = true
func _ready():
	$Timer.connect("timeout",self, "timeout")

func timeout():
	if kill_on_timeout:
		queue_free()
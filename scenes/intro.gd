extends Control
export var game_path = ""
func _ready():
	$Timer.connect("timeout", self, "timeout")

func timeout():
	Transition.change_scene(game_path)
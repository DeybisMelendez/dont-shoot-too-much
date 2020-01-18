extends CanvasLayer

func change_scene(scene):
	$AnimationPlayer.play("in")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(scene)
	$AnimationPlayer.play("out")

func reload():
	$AnimationPlayer.play("in")
	yield($AnimationPlayer, "animation_finished")
	get_tree().reload_current_scene()
	$AnimationPlayer.play("out")
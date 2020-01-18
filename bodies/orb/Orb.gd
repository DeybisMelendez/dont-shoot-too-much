extends Area2D
var taken = false
func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if not taken:
		if body.is_in_group("ship"):
			taken = true
			body.reset_percent()
			$Sprite.hide()
			$AudioStreamPlayer.play()
			yield($AudioStreamPlayer,"finished")
			queue_free()
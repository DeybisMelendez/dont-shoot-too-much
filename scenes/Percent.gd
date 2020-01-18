extends CanvasLayer

func _ready():
	$Best.text = "Best: " + str(Data.data)

func show_percent(percent):
	$Label.text = str(percent + 1)
	$AnimationPlayer.play("show")

func update_score(score):
	$Score.text = "Score: " + str(score)
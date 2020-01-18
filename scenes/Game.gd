extends Node2D

export (PackedScene) var Enemy
export (PackedScene) var Orb
const SCREEN_CENTER = Vector2(512, 300)
const RADIO = 300
var turn = 0
func _ready():
	$Timer.connect("timeout", self, "spawn_enemy")

func spawn_enemy():
	var random = Vector2(randi()% 1024, randi()%600)
	var pos = (random - SCREEN_CENTER).normalized() * RADIO
	pos += SCREEN_CENTER
	var new_enemy = Enemy.instance()
	new_enemy.position = pos
	$Node2D.add_child(new_enemy)
	if turn > 2:
		spawn_orb()
		turn = 0
	turn += 1

func spawn_orb():
	var random = Vector2(randi()% 1024, randi()%600)
	var pos = (random - SCREEN_CENTER).normalized() * RADIO/2
	pos += SCREEN_CENTER
	var new_orb = Orb.instance()
	new_orb.position = pos
	$Node2D.add_child(new_orb)

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel"):
			get_tree().paused = not get_tree().paused
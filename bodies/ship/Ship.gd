extends KinematicBody2D

export (PackedScene) var Bullet

const SPEED_ROT = 10/PI
const SPEED_DIR = 200
const SPEED_BREAK = 0.1
const WEIGHT = 0.025
const SCREEN_CENTER = Vector2(512, 300)
const RADIO = 240
var dead = false
var dir = Vector2.ZERO
var can_shoot = true
onready var Spawn = $Spawn
var percent = 99
var score = 0

func _ready():
	$Timer.connect("timeout", self, "timeout")

func timeout():
	can_shoot = true

func _physics_process(_delta):
	if not dead:
		var mouse_pos = get_global_mouse_position() - global_position
		rotation = atan2(mouse_pos.y, mouse_pos.x)
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			dir = Vector2(cos(rotation), sin(rotation)) * SPEED_DIR
		else:
			dir.x = lerp(dir.x, 0, WEIGHT)
			dir.y = lerp(dir.y, 0, WEIGHT)
		dir = move_and_slide(dir)
		
		# Validamos la posicion de la nave y la colocamos dentro del radio si se sale
		if global_position.distance_to(SCREEN_CENTER) > RADIO:
			var pos = (global_position - SCREEN_CENTER).normalized() * RADIO
			global_position = pos + SCREEN_CENTER
		
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_shoot:
			if randi()% 100 < percent:
				var new_bullet = Bullet.instance()
				new_bullet.direction = rotation
				new_bullet.position = Spawn.global_position
				get_parent().add_child(new_bullet)
				can_shoot = false
				$Timer.start()
				percent -= 1
				$Percent.show_percent(percent)
			else:
				kill()
		if get_slide_count() > 0:
			kill()

func kill():
	dead = true
	$Sprite.hide()
	$ParticleCPU.emitting = true
	$ParticleCPU.play()
	if score > Data.data - 1:
		Data.data = score + 1
		Data.save_data()
		Kongregate.submit_stats("Best", Data.data)
	Transition.reload()

func reset_percent():
	percent += randi()%5+1
	if percent > 99:
		percent = 99
	$Percent.show_percent(percent)

func add_point():
	score += 1
	$Percent.update_score(score)
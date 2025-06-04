extends CharacterBody2D
@onready var state_label: Label = $Label
@onready var speed_label: Label = $CanvasLayer/Control/Label

var speed: float = 0
enum States {IDLE, WALK, ACTION}
var state: States = States.IDLE
var direction
var playerdirection = "Down"
var cycle_hp = 4

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	boost_speed()
	print(speed)
	state_machine()
	speed_label.text = "Speed" + str(speed)

func state_machine():
	if velocity != Vector2.ZERO: 
		state = States.WALK
	if Input.is_action_just_pressed("ui_accept"):
		state = States.ACTION
	if velocity == Vector2.ZERO:
		state = States.IDLE

	if state == States.IDLE:
		state_label.text = "State: Idle"
	elif state == States.WALK:
		state_label.text = "State: Walk"
	elif state == States.ACTION:
		state_label.text = "State: Action"


func _on_area_2d_area_entered(area: Area2D) -> void:
	match area.name:
		"Barrier_1":
			cycle_hp -= 1
			print(cycle_hp)
		"Barrier_2":
			cycle_hp -= 1
			print(cycle_hp)


func boost_speed():
	if Input.is_action_just_pressed("speed_boost"):
		speed += 40
		if speed > 500:
			speed = 500
	for i in 1:
		speed -= 1
		if speed < 1:
			speed = 1

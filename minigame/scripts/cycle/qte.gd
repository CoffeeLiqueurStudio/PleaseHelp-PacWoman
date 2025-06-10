extends Control
#
#const QTE_LENGTH := 5
#const KEYS := ['A', 'D']
#const TIME_LIMIT := 5.5  # Время на каждый ввод (в секундах)
#
#var qte_sequence: Array[String] = []
#var current_index := 0
#var time_left := TIME_LIMIT
#var active := false
#
#@onready var labels := $VBoxContainer.get_children()
#@onready var info_label := $InfoLabel
#
#func _ready():
	#start_qte()
#
#func start_qte():
	#qte_sequence = []
	#current_index = 0
	#active = true
	#info_label.text = ""
	#generate_sequence()
	#update_labels()
	#time_left = TIME_LIMIT
#
#func generate_sequence():
	#for i in QTE_LENGTH:
		#qte_sequence.append(KEYS[randi() % KEYS.size()])
#
#func update_labels():
	#for i in range(QTE_LENGTH):
		#if i < labels.size():
			#labels[i].text = qte_sequence[i]
			#labels[i].modulate = Color.WHITE if i >= current_index else Color.GREEN
#
#func _process(delta):
	#
	#if not active:
		#return
	#time_left -= delta
	#if time_left <= 0:
		#fail_qte()
#
#func _input(event):
	#if not active or not event is InputEventKey or not event.pressed:
		#return
#
	#var expected_key := qte_sequence[current_index]
	#var pressed_key := OS.get_keycode_string(event.keycode)
#
	#if pressed_key == expected_key:
		#current_index += 1
		#time_left = TIME_LIMIT
		#update_labels()
#
	#if current_index >= QTE_LENGTH:
			#win_qte()
	#elif !pressed_key in KEYS:
			#fail_qte()
#
#func win_qte():
	#active = false
	#info_label.text = "Успех!"
#
#func fail_qte():
	#active = false
	#info_label.text = "Провал!"

	

#const QTE_LENGTH := 5
#const KEYS := ['A', 'D']
#const TIME_LIMIT := 1.5
#
#var qte_sequence: Array[String] = []
#var current_index := 0
#var time_left := TIME_LIMIT
#var active := false
#
#@onready var key_label := $KeyLabel
#@onready var info_label := $InfoLabel
#
#func _ready():
	#start_qte()
#
#func start_qte():
	#qte_sequence.clear()
	#current_index = 0
	#active = true
	#info_label.text = ""
	#key_label.modulate = Color.WHITE
	#generate_sequence()
	#show_next_key()
	#time_left = TIME_LIMIT
#
#func generate_sequence():
	#for i in QTE_LENGTH:
		#qte_sequence.append(KEYS[randi() % KEYS.size()])
#
#func show_next_key():
	#if current_index < qte_sequence.size():
		#key_label.text = qte_sequence[current_index]
		#key_label.scale = Vector2(1.5, 1.5)
		#key_label.modulate = Color.WHITE
		## Простая "анимация" уменьшения
		#key_label.create_tween().tween_property(key_label, "scale", Vector2.ONE, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
#
#func _process(delta):
	#if not active:
		#return
	#time_left -= delta
	#if time_left <= 0:
		#fail_qte()
#
#func _input(event):
	#if not active or not event is InputEventKey or not event.pressed:
		#return
#
	#var pressed_key := ""
	#if event.keycode == KEY_A:
		#pressed_key = "A"
	#elif event.keycode == KEY_D:
		#pressed_key = "D"
	#else:
		#return  # Игнорируем другие клавиши
#
	#var expected_key := qte_sequence[current_index]
	#if pressed_key == expected_key:
		#current_index += 1
		#if current_index >= QTE_LENGTH:
			#win_qte()
		#else:
			#show_next_key()
			#time_left = TIME_LIMIT
	#else:
		#fail_qte()
#
#func win_qte():
	#active = false
	#info_label.text = "Успех!"
	#key_label.modulate = Color.LIME_GREEN
#
#func fail_qte():
	#active = false
	#info_label.text = "Провал!"
	#key_label.modulate = Color.RED


const QTE_LENGTH := 5
const KEYS := ['A', 'D']
const TIME_LIMIT := 1.5

var qte_sequence: Array[String] = []
var current_index := 0
var time_left := TIME_LIMIT
var active := false

@onready var a_label := $HBoxContainer/ALabel
@onready var d_label := $HBoxContainer/DLabel
@onready var info_label := $InfoLabel


func _ready():
	a_label.text = "A"
	d_label.text = "D"
	start_qte()

func start_qte():
	qte_sequence.clear()
	current_index = 0
	active = true
	info_label.text = ""
	generate_sequence()
	show_next_key()
	time_left = TIME_LIMIT

func generate_sequence():
	for i in QTE_LENGTH:
		qte_sequence.append(KEYS[randi() % KEYS.size()])

func show_next_key():
	# Сбросим цвета
	a_label.modulate = Color.GRAY
	d_label.modulate = Color.GRAY

	# Подсветим нужную кнопку
	var key := qte_sequence[current_index]
	if key == "A":
		a_label.modulate = Color.WHITE
		animate_label(a_label)
	elif key == "D":
		d_label.modulate = Color.WHITE
		animate_label(d_label)

func animate_label(label: Label):
	label.scale = Vector2(1.5, 1.5)
	label.create_tween().tween_property(label, "scale", Vector2.ONE, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _process(delta):
	if not active:
		return
	time_left -= delta
	if time_left <= 0:
		fail_qte()

func _input(event):
	if not active or not event is InputEventKey or not event.pressed:
		return

	var pressed_key := ""
	if event.keycode == KEY_A:
		pressed_key = "A"
	elif event.keycode == KEY_D:
		pressed_key = "D"
	else:
		return  # Не нужная клавиша — игнорируем

	var expected_key := qte_sequence[current_index]
	if pressed_key == expected_key:
		current_index += 1
		if current_index >= QTE_LENGTH:
			win_qte()
		else:
			show_next_key()
			time_left = TIME_LIMIT
	else:
		fail_qte()

func win_qte():
	active = false
	info_label.text = "Успех!"
	a_label.modulate = Color.LIME_GREEN
	d_label.modulate = Color.LIME_GREEN

func fail_qte():
	active = false
	info_label.text = "Провал!"
	a_label.modulate = Color.RED
	d_label.modulate = Color.RED

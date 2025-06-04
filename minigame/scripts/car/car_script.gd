extends CharacterBody2D
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@export var speed = 500
@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	path_follow_2d.progress += speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	match area.name:
		"Barrier_1":
			speed = 250
			#print(speed)
			timer.start()
		"Barrier_2":
			speed = 100
			#print(speed)
			timer.start()
func _on_timer_timeout() -> void:
	speed = 500
	#print(speed)

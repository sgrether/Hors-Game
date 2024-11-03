extends CharacterBody2D

@export var speed := 600
var can_shoot: bool = true
#signal lazer(pos) 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	shoot()
	
func shoot():
	if Input.is_action_pressed("ui_accept") and can_shoot:
		SignalBus.lazer.emit($LazerStartPos.global_position)
		can_shoot = false
		$LazerTimer.start()

func _on_lazer_timer_timeout() -> void:
	can_shoot = true

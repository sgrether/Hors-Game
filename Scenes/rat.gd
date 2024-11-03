extends Area2D

var explosions_scene: PackedScene = load("res://Scenes/explosions.tscn")

var speed: int
var rotation_speed: int

func _ready() -> void:
	var rand := RandomNumberGenerator.new()
	
	#Start position
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rand.randi_range(50, width-50)
	var random_y = rand.randi_range(50, 200)
	position = Vector2(random_x, random_y)
	
	speed = rand.randi_range(100, 300)
	rotation_speed = rand.randi_range(-100, 100)
	
func _process(delta: float) -> void:
	var height = get_viewport().get_visible_rect().size[1]
	position += Vector2(0,1.0) * speed * delta
	rotation_degrees += rotation_speed * delta
	
	if position.y > height:
		queue_free()
	
func _on_body_entered(_body: Node2D) -> void:
	#print("Kills you with hammers")
	get_tree().change_scene_to_file.bind("res://Scenes/GameOver.tscn").call_deferred()
	
func _on_explosion_animation_finished() -> void:
	$Explosions.get_child(0).queue_free()

func _on_area_entered(_area: Area2D) -> void:
	#print("Lazer??")
	set_deferred("monitoring", false)
	$"Rat Sprite".hide()
	explosionCreator()
	SignalBus.rat_died.emit()
	
func explosionCreator() -> void:
	var explosion = explosions_scene.instantiate()
	explosion.get_child(0).animation_finished.connect(_on_explosion_animation_finished)
	$Explosions.add_child(explosion)

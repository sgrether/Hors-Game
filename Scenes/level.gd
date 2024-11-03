extends Node2D

var rat_scene: PackedScene = load("res://Scenes/rat.tscn")
var lazer_scene: PackedScene = load("res://Scenes/lazer.tscn")
var killCounter = 0

func _ready() -> void:
	SignalBus.rat_died.connect(_on_rat_died)
	SignalBus.lazer.connect(_on_player_lazer)

func _process(_delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var rat = rat_scene.instantiate()
	$Rats.add_child(rat)
	#connect("rat_died", rat._on_died)

func _on_player_lazer(pos) -> void:
	#print("pissin on rats", pos)
	var lazer = lazer_scene.instantiate()
	$Lazers.add_child(lazer)
	lazer.position = pos
	
func randNums(x: int, y: int) -> Vector2:
	var rand = RandomNumberGenerator.new()
	var width = get_viewport().get_visible_rect().size[0]
	var height = get_viewport().get_visible_rect().size[1]
	var random_x = rand.randi_range(x, width-y)
	var random_y = rand.randi_range(x, height - y)
	return Vector2(random_x, random_y)

func _on_rat_died() -> void:
	#print("I am deceased.")
	killCounter += 1
	$CanvasLayer/KillCount.text = str(killCounter)

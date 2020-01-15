extends Node2D

# posições de spawn
export var leftXPos = -117
export var rightXPos = 1386
export var TopYPos = 58
export var BottomYPos = 654
export var maxEnemySpawnAtTime = 4
export var waitTimeReduceNumber = 0.1

onready var timer = get_node("Timer");

onready var enemies = [ResourceLoader.load("res://entities/enemies/Einger.tscn"), ResourceLoader.load("res://entities/enemies/Bluu.tscn")]

# var images = ["res://assets/Einger.png", "res://assets/Bluu.png"]

var posX = [leftXPos, rightXPos]

var current_scene = null
# var timer = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	randomize()
	pass

func _on_Timer_timeout():
	var x = rand_range(1, maxEnemySpawnAtTime) 
	# for i in range(x):
	spawn_enemies()

func manipulate_timer():
	if current_scene.score%5 == 0 && timer.wait_time > 0.3:
		timer.wait_time -= waitTimeReduceNumber
		print(timer.wait_time)
	pass

func spawn_enemies():
	var newEnemy = enemies[rand_range(0,2)].instance()
	# newEnemy.get_node("Area2D/Sprite").texture = load(images[0])
	var pos = Vector2(posX[rand_range(0,2)], rand_range(TopYPos,BottomYPos))
	if pos.x < 0:
		newEnemy.flip_enemy()
	newEnemy.position = pos
	get_parent().add_child(newEnemy)
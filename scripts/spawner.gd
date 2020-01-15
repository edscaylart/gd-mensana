extends Node

# posições de spawn
export var leftXPos = -117
export var rightXPos = 1386
export var TopYPos = 58
export var BottomYPos = 654
# export (int)var maxEnemySpawnAtTime = 4
export (int)var scoreToIncreaseTime = 10
export (float)var waitTimeReduceNumber = 0.1
export (float)var waitTimeMax = 0.25

onready var timer = get_node("Timer");

onready var enemies = [ResourceLoader.load("res://entities/enemies/Einger.tscn"), ResourceLoader.load("res://entities/enemies/Bluu.tscn")]

var posX = [leftXPos, rightXPos]

var score_node = null
var lastScoreOnTime = 0

func _ready():
	for node in get_tree().get_nodes_in_group("actors"):
		if node.name == "AnimationPlayer":
			score_node = node.get_node("Score")
			lastScoreOnTime = score_node.score
			break
	randomize()
	pass

func _on_Timer_timeout():
	spawn_enemies()
	manipulate_timer()

func manipulate_timer():
	if score_node.score > lastScoreOnTime && score_node.score%scoreToIncreaseTime == 0 && timer.wait_time > waitTimeMax:
		timer.wait_time -= waitTimeReduceNumber
		lastScoreOnTime = score_node.score
		print(timer.wait_time)
	pass

func spawn_enemies():
	var newEnemy = enemies[rand_range(0,2)].instance()
	var pos = Vector2(posX[rand_range(0,2)], rand_range(TopYPos,BottomYPos))
	if pos.x < 0:
		newEnemy.flip_enemy()
	newEnemy.position = pos
	get_parent().add_child(newEnemy)